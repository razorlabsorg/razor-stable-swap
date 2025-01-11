module razor_stable_swap::two_pool {
    use std::string::{Self, String};
    use std::option;
    use std::bcs;
    use std::vector;
    use std::signer;
    
    use aptos_framework::event;
    use aptos_framework::object::{Self, Object, ConstructorRef};
    use aptos_framework::fungible_asset::{Self, FungibleAsset, FungibleStore, MintRef, BurnRef, TransferRef, Metadata};
    use aptos_framework::primary_fungible_store;
    use aptos_framework::timestamp;

    use aptos_std::comparator;

    use razor_stable_swap::controller;

    friend razor_stable_swap::factory;
    friend razor_stable_swap::two_pool_info;
    friend razor_stable_swap::two_pool_deployer;
    friend razor_stable_swap::router;

    // Constants
    const N_COINS: u64 = 2;
    const MAX_DECIMAL: u8 = 18;
    const FEE_DENOMINATOR: u256 = 10000000000; // 1e10
    const PRECISION: u256 = 1000000000000000000; // 1e18

    const MAX_ADMIN_FEE: u256 = 10000000000; // 1e10
    const MAX_FEE: u256 = 5000000000; // 5e9
    const MAX_A: u256 = 1000000; // 1e6
    const MAX_A_CHANGE: u256 = 10;

    const LP_TOKEN_DECIMALS: u8 = 8;
    const KILL_DEADLINE_DT: u64 = 5184000; // 2 * 30 * 24 * 60 * 60 (2 months in seconds)
    
    const ADMIN_ACTIONS_DELAY: u64 = 259200; // 3 days in seconds
    const MIN_RAMP_TIME: u64 = 86400; // 1 day in seconds

    /// Pool has already been initialized
    const ERROR_POOL_ALREADY_INITIALIZED: u64 = 1;
    /// Caller is not authorized to make this call
    const ERROR_UNAUTHORIZED: u64 = 2;
    /// Invalid coin type for the operation
    const ERROR_INVALID_COIN: u64 = 3;
    /// Pool is in a killed state
    const ERROR_POOL_IS_KILLED: u64 = 4;
    /// Invalid number of coins for the operation
    const ERROR_INVALID_COIN_COUNT: u64 = 5;
    /// Invalid amplification coefficient (A)
    const ERROR_INVALID_A: u64 = 6;
    /// Fee is set too high
    const ERROR_FEE_TOO_HIGH: u64 = 7;
    /// Admin fee is set too high
    const ERROR_ADMIN_FEE_TOO_HIGH: u64 = 8;
    /// Coin decimal precision is too high
    const ERROR_COIN_DECIMAL_TOO_HIGH: u64 = 9;
    /// Invalid amounts provided for the operation
    const ERROR_INVALID_AMOUNTS: u64 = 10;
    /// New D value must be greater than the old D value
    const ERROR_D1_MUST_BE_GREATER_THAN_D0: u64 = 11;
    /// Initial deposit requires all coins to be added
    const ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS: u64 = 12;
    /// Insufficient amount minted
    const ERROR_INSUFFICIENT_MINT_AMOUNT: u64 = 13;
    /// Invalid coin index provided
    const ERROR_INVALID_COIN_INDEX: u64 = 14;
    /// Insufficient output amount for the operation
    const ERROR_INSUFFICIENT_OUTPUT_AMOUNT: u64 = 16;
    /// Insufficient withdrawal amount
    const ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT: u64 = 17;
    /// Amount provided is zero
    const ERROR_ZERO_AMOUNT: u64 = 18;
    /// Total supply is zero
    const ERROR_ZERO_TOTAL_SUPPLY: u64 = 19;
    /// Invalid D value calculated
    const ERROR_INVALID_D: u64 = 20;
    /// Exceeds maximum burn amount
    const ERROR_EXCEED_MAX_BURN_AMOUNT: u64 = 21;
    /// Insufficient coins removed from the pool
    const ERROR_INSUFFICIENT_COINS_REMOVED: u64 = 22;
    /// Amplification coefficient (A) ramping is already in progress
    const ERROR_RAMP_A_IN_PROGRESS: u64 = 23;
    /// Ramp time is too short
    const ERROR_RAMP_TIME_TOO_SHORT: u64 = 24;
    /// Invalid amplification coefficient (A) value
    const ERROR_INVALID_A_VALUE: u64 = 25;
    /// Admin deadline is not zero when it should be
    const ERROR_ADMIN_DEADLINE_NOT_ZERO: u64 = 26;
    /// Admin deadline is zero when it shouldn't be
    const ERROR_ADMIN_DEADLINE_IS_ZERO: u64 = 27;
    /// Fee change attempted too early
    const ERROR_FEE_CHANGE_TOO_EARLY: u64 = 28;
    /// No admin fees available
    const ERROR_NO_ADMIN_FEES: u64 = 29;
    /// Kill deadline has already passed
    const ERROR_KILL_DEADLINE_PASSED: u64 = 30;
    /// Pool is already in a killed state
    const ERROR_POOL_ALREADY_KILLED: u64 = 31;
    /// Pool is not in a killed state
    const ERROR_POOL_NOT_KILLED: u64 = 32;
    /// Balance exceeds the allowed limit
    const ERROR_EXCESS_BALANCE: u64 = 33;
    /// Fewer coins received in exchange than expected
    const ERROR_FEWER_COINS_IN_EXCHANGE: u64 = 34;

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct TwoPool has key {
        coins: vector<Object<FungibleStore>>,
        balances: vector<u256>,
        fee: u256,
        admin_fee: u256,
        lp_token: LPTokenRefs,
        token0: Object<Metadata>,
        token1: Object<Metadata>,
        precision_muls: vector<u256>,
        rates: vector<u256>,
        initial_a: u256,
        future_a: u256,
        initial_a_time: u64,
        future_a_time: u64,
        kill_deadline: u64,
        admin_actions_deadline: u64,
        future_fee: u256,
        future_admin_fee: u256,
        is_killed: bool,
    }

    // Events
    #[event]
    struct AddLiquidityEvent has drop, store {
        provider: address,
        token_amounts: vector<u256>,
        fees: vector<u256>,
        inv: u256,
        token_supply: u256,
    }
    
    #[event]
    struct RemoveLiquidityEvent has drop, store {
        provider: address,
        token_amounts: vector<u256>,
        token_supply: u256,
    }

    #[event]
    struct RemoveLiquidityImbalanceEvent has drop, store {
        provider: address,
        token_amounts: vector<u256>,
        fees: vector<u256>,
        inv: u256, // invariant
        token_supply: u256,
    }

    #[event]
    struct RemoveLiquidityOne has drop, store {
        provider: address,
        index: u64,
        token_amount: u256,
        coin_amount: u256
    }

    #[event]
    struct TokenExchangeEvent has drop, store {
        buyer: address,
        sold_id: u256,
        tokens_sold: u256,
        bought_id: u256,
        tokens_bought: u256,
    }

    #[event]
    struct RampAEvent has drop, store {
        old_a: u256,
        new_a: u256,
        initial_time: u64,
        future_time: u64,
    }

    #[event]
    struct StopRampAEvent has drop, store {
        a: u256,
        t: u64
    }

    #[event]
    struct CommitNewFeeEvent has drop, store {
        deadline: u64,
        new_fee: u256,
        new_admin_fee: u256,
    }

    #[event]
    struct ApplyNewFeeEvent has drop, store {
        new_fee: u256,
        new_admin_fee: u256,
    }

    #[event]
    struct LPTokenRefs has drop, store {
        burn_ref: BurnRef,
        mint_ref: MintRef,
        transfer_ref: TransferRef,
    }

    #[event]
    struct RevertParameters has drop, store {}

    #[event]
    struct KillEvent has drop, store {}

    #[event]
    struct UnkillEvent has drop, store {}

    public(friend) fun initialize(
        coins: vector<Object<Metadata>>,
        a: u256,
        fee: u256,
        admin_fee: u256
    ): Object<TwoPool> {
        assert!(vector::length(&coins) == N_COINS, ERROR_INVALID_COIN_COUNT);

        let token0 = *vector::borrow(&coins, 0);
        let token1 = *vector::borrow(&coins, 1);

        if (!is_sorted(token0, token1)) {
            vector::reverse(&mut coins);
            return initialize(coins, a, fee, admin_fee)
        };
        // Validate inputs
        assert!(a > 0 && a <= MAX_A, ERROR_INVALID_A);
        assert!(fee <= MAX_FEE, ERROR_FEE_TOO_HIGH);
        assert!(admin_fee <= MAX_ADMIN_FEE, ERROR_ADMIN_FEE_TOO_HIGH);

        // Create the pool object
        let pool_constructor_ref = create_lp_token(token0, token1);
        let pool_signer = object::generate_signer(pool_constructor_ref);
        let pool_lp = object::object_from_constructor_ref<Metadata>(pool_constructor_ref);

        fungible_asset::create_store(pool_constructor_ref, pool_lp);

        // Initialize balances and precision multipliers
        let balances = vector::empty<u256>();
        let precision_muls = vector::empty<u256>();
        let rates = vector::empty<u256>();
        let coin_stores = vector::empty<Object<FungibleStore>>();

        let i = 0;
        while (i < N_COINS) {
            let coin = vector::borrow(&coins, i);
            let coin_decimals = fungible_asset::decimals(*coin);
            assert!(coin_decimals <= MAX_DECIMAL, ERROR_COIN_DECIMAL_TOO_HIGH);

            vector::push_back(&mut balances, 0);
            let precision_mul = pow(10, (MAX_DECIMAL - coin_decimals as u64));
            vector::push_back(&mut precision_muls, precision_mul);
            vector::push_back(&mut rates, PRECISION * precision_mul);

            // Create a store for each coin
            vector::push_back(&mut coin_stores, create_token_store(&pool_signer, *coin));
            i = i + 1;
        };

        // Move the TwoPool resource to the pool object
        move_to(&pool_signer, TwoPool {
            coins: coin_stores,
            lp_token: create_lp_token_refs(pool_constructor_ref),
            token0,
            token1,
            balances,
            precision_muls,
            rates,
            fee,
            admin_fee,
            initial_a: a,
            future_a: a,
            initial_a_time: 0,
            future_a_time: 0,
            kill_deadline: timestamp::now_seconds() + KILL_DEADLINE_DT,
            admin_actions_deadline: 0,
            future_fee: 0,
            future_admin_fee: 0,
            is_killed: false,
        });

        // Return the pool object
        let pool = object::convert(pool_lp);
        pool
    }

    public(friend) fun fee(pool: &Object<TwoPool>): u256 acquires TwoPool {
        pool_data<TwoPool>(pool).fee
    }

    /// Calculates the amplification coefficient of the pool (A)
    fun get_a(pool: &TwoPool): u256 {
        let t1 = pool.future_a_time;
        let a1 = pool.future_a;

        if (timestamp::now_seconds() < t1) {
            let a0 = pool.initial_a;
            let t0 = pool.initial_a_time;
            let t = timestamp::now_seconds();

            // Compute the linear interpolation between a0 and a1
            if (a1 > a0) {
                a0 + (a1 - a0) * (t - t0 as u256) / (t1 - t0 as u256)
            } else {
                a0 - (a0 - a1) * (t - t0 as u256) / (t1 - t0 as u256)
            }
        } else {
            // If we're past t1, just return a1
            a1
        }
    }

    #[view]
    public fun a(pool: Object<TwoPool>): u256 acquires TwoPool {
        let pool_data = pool_data<TwoPool>(&pool);
        let t1 = pool_data.future_a_time;
        let a1 = pool_data.future_a;

        if (timestamp::now_seconds() < t1) {
            let a0 = pool_data.initial_a;
            let t0 = pool_data.initial_a_time;
            let t = timestamp::now_seconds();

            // Compute the linear interpolation between a0 and a1
            if (a1 > a0) {
                a0 + (a1 - a0) * (t - t0 as u256) / (t1 - t0 as u256)
            } else {
                a0 - (a0 - a1) * (t - t0 as u256) / (t1 - t0 as u256)
            }
        } else {
            // If we're past t1, just return a1
            a1
        }
    }

    /// Calculates the current scaled balances of the pool
    fun xp(pool: &TwoPool): vector<u256> {
        let result = vector::empty<u256>();
        let i = 0;
        while (i < N_COINS) {
            let balance = (fungible_asset::balance(*vector::borrow(&pool.coins, i)) as u256);
            let rate = *vector::borrow(&pool.rates, i);
            vector::push_back(&mut result, balance * rate / PRECISION);
            i = i + 1;
        };
        result
    }

    /// Calculates the scaled balances given a set of balances
    fun xp_mem(balances: &vector<u256>, pool: &TwoPool): vector<u256> {
        let result = vector::empty<u256>();
        let i = 0;
        while (i < N_COINS) {
            let balance = *vector::borrow(balances, i);
            let rate = *vector::borrow(&pool.rates, i);
            vector::push_back(&mut result, balance * rate / PRECISION);
            i = i + 1;
        };
        result
    }

    public(friend) fun get_d(xp: &vector<u256>, amp: u256): u256 {
        let sum_x = sum_vector(xp); // sum of all xp
        if (sum_x == 0) {
            return 0
        };

        let ann = amp * (N_COINS as u256); // A*n^n
        let d = sum_x;
        let d_prev: u256;
        
        let i = 0;
        while (i < 255) {
            let d_p = d;
            let j = 0;
            while (j < N_COINS) {
                d_p = d_p * d / (*vector::borrow(xp, j) * (N_COINS as u256));
                j = j + 1;
            };
            d_prev = d;
            d = ((ann * sum_x + d_p * (N_COINS as u256)) * d) 
                / ((ann - 1) * d + ((N_COINS + 1) as u256) * d_p);
            
            if (d > d_prev) {
                if (d - d_prev <= 1) {
                    return d
                }
            } else {
                if (d_prev - d <= 1) {
                    return d
                }
            };
            i = i + 1;
        };

        // If we've reached here, we've hit max iterations without converging
        d
    }

    fun get_d_mem(balances: &vector<u256>, amp: u256, pool: &TwoPool): u256 {
        let xp = xp_mem(balances, pool);
        get_d(&xp, amp)
    }

    #[view]
    public fun get_virtual_price(pool: Object<TwoPool>): u256 acquires TwoPool {
        let pool_data = pool_data<TwoPool>(&pool);
        let amp = get_a(pool_data);
        let xp = xp(pool_data);
        let d = get_d(&xp, amp);

        let token_supply  = (option::extract(&mut fungible_asset::supply<TwoPool>(pool)) as u256);
        (d * PRECISION) / token_supply
    }

    public(friend) fun lp_token_supply(pool: Object<TwoPool>): u128 {
        option::extract(&mut fungible_asset::supply(pool))
    }

    #[view]
    public fun calc_token_amount(
        pool: Object<TwoPool>,
        amounts: vector<u256>,
        is_deposit: bool
    ): u256 acquires TwoPool {
        let pool_data = pool_data<TwoPool>(&pool);
        let token0 = pool_data.token0;
        let token1 = pool_data.token1;
        
        // Ensure the amounts vector has the correct length
        assert!(vector::length(&amounts) == N_COINS, ERROR_INVALID_AMOUNTS);

        let amp = get_a(pool_data);
        let old_balances = vector::empty<u256>();
        let i = 0;
        while (i < N_COINS) {
            vector::push_back(&mut old_balances, (fungible_asset::balance(*vector::borrow(&pool_data.coins, i)) as u256));
            i = i + 1;
        };

        let d0 = get_d_mem(&old_balances, amp, pool_data);

        let new_balances = vector::empty<u256>();
        i = 0;
        while (i < N_COINS) {
            let amount = *vector::borrow(&amounts, i);
            if (is_deposit) {
                vector::push_back(&mut new_balances, *vector::borrow(&old_balances, i) + amount);
            } else {
                vector::push_back(&mut new_balances, *vector::borrow(&old_balances, i) - amount);
            };
            i = i + 1;
        };

        let d1 = get_d_mem(&new_balances, amp, pool_data);

        let pool = stable_swap_pool(token0, token1);
        let total_supply_opt = fungible_asset::supply(pool);
        let total_supply = option::extract(&mut total_supply_opt);

        let diff = if (is_deposit) {
            d1 - d0
        } else {
            d0 - d1
        };

        (diff * (total_supply as u256)) / d0
    }

    // REPLICATE ROUTER::ADD_LIQUIDITY -> PAIR::MINT 
    public(friend) fun add_liquidity(
        pool: Object<TwoPool>,
        amounts: vector<FungibleAsset>,
        min_mint_amount: u256,
        sender: &signer
    ): FungibleAsset acquires TwoPool {

        let token0 = fungible_asset::metadata_from_asset(vector::borrow(&amounts, 0));
        let token1 = fungible_asset::metadata_from_asset(vector::borrow(&amounts, 1));

        // TODO: THOROUGHLY SCRUTINIZE THIS
        if (!is_sorted(token0, token1)) {
            vector::reverse(&mut amounts);
            return add_liquidity(pool, amounts, min_mint_amount, sender)
        };

        let pool_data = pool_data_mut<TwoPool>(&pool);

        assert!(!pool_data.is_killed, ERROR_POOL_IS_KILLED);
        assert!(vector::length(&amounts) == N_COINS, ERROR_INVALID_AMOUNTS);

        let fees = vector::empty<u256>();
        let _fee = (pool_data.fee * (N_COINS as u256)) / (4 * ((N_COINS - 1) as u256));
        let amp = get_a(pool_data);

        let old_balances = xp(pool_data);
        let d0 = 0;
        let token_supply = (option::extract(&mut fungible_asset::supply<TwoPool>(pool)) as u256);
        if (token_supply > 0) {
            d0 = get_d(&old_balances, amp);
        };

        let new_balances = old_balances;
        for (i in 0..N_COINS) {
            let amount = fungible_asset::amount(vector::borrow(&amounts, i));
            if (token_supply == 0) {
                assert!(amount > 0, ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS);
            };
            *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) + (amount as u256);
        };

        let d1 = get_d(&new_balances, amp);
        assert!(d1 > d0, ERROR_D1_MUST_BE_GREATER_THAN_D0);

        // Recalculate the invariant accounting for fees
        let d2 = d1;
        let mint_amount: u256;
        if (token_supply > 0) {

            for (i in 0..N_COINS) {
                let ideal_balance = d1 * *vector::borrow(&old_balances, i) / d0;
                let difference = if (ideal_balance > *vector::borrow(&new_balances, i)) {
                    ideal_balance - *vector::borrow(&new_balances, i)
                } else {
                    *vector::borrow(&new_balances, i) - ideal_balance
                };
                *vector::borrow_mut(&mut fees, i) = _fee * difference / FEE_DENOMINATOR;
                *vector::borrow_mut(&mut pool_data.balances, i) = *vector::borrow(&new_balances, i) - (((*vector::borrow(&fees, i) * pool_data.admin_fee) / FEE_DENOMINATOR));
                *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) - *vector::borrow(&fees, i);
            };

            d2 = get_d(&new_balances, amp);
            mint_amount = token_supply * (d2 - d0) / d0;
        } else {
            mint_amount = d1;
            pool_data.balances = new_balances;
        };

        assert!(mint_amount >= min_mint_amount, ERROR_INSUFFICIENT_MINT_AMOUNT);

        // Take coins from the sender and mint LP tokens
        vector::reverse(&mut amounts);
        for (i in 0..N_COINS) {
            let coin = vector::pop_back(&mut amounts);
            fungible_asset::deposit(*vector::borrow(&pool_data.coins, i), coin);
        };
        let lp_tokens = fungible_asset::mint(&pool_data.lp_token.mint_ref, (mint_amount as u64));

        // Emit event
        event::emit(AddLiquidityEvent {
            provider: signer::address_of(sender),
            token_amounts: vector::map_ref(&amounts, |b| (fungible_asset::amount(b) as u256)),
            fees,
            inv: d2,
            token_supply: token_supply + mint_amount,
        });

        vector::destroy_empty(amounts);
        lp_tokens
    }

    fun get_y(i: u64, j: u64, x: u256, xp: &vector<u256>, pool: &TwoPool): u256 {
        assert!(i != j && i < N_COINS && j < N_COINS, ERROR_INVALID_COIN);
        let amp = get_a(pool);
        let d = get_d(xp, amp);
        let c = d;
        let s = 0u256;
        let n = (N_COINS as u256);
        let ann = amp * n;

        let _x = 0u256;

        for (k in 0..N_COINS) {
            if (k == i) {
                _x = x;
            } else if (k != j) {
                _x = *vector::borrow(xp, k);
            } else {
                continue
            };
            s = s + _x;
            c = c * d / (_x * n);
        };

        c = c * d / (ann * n);
        let b = s + d / ann;
        let y_prev: u256;
        let y = d;

        for (_m in 0..255) {
            y_prev = y;
            y = (y*y + c) / (2 * y + b - d);
            if (y > y_prev) {
                if (y - y_prev <= 1) {
                    return y
                }
            } else {
                if (y_prev - y <= 1) {
                    return y
                }
            };
        };
        y
    }

    public(friend) fun get_dy(
        i: u64, 
        j: u64, 
        dx: u256,
        pool: &Object<TwoPool>, 
    ): u256 acquires TwoPool {
        let pool_data = pool_data<TwoPool>(pool);
        assert!(i != j && i < N_COINS && j < N_COINS, ERROR_INVALID_COIN_INDEX);

        let xp = xp(pool_data);
        let rates = &pool_data.rates;

        let x = *vector::borrow(&xp, i) + (dx * *vector::borrow(rates, i) / PRECISION);
        let y = get_y(i, j, x, &xp, pool_data);
        let dy = (*vector::borrow(&xp, j) - y - 1) * PRECISION / *vector::borrow(rates, j);
        let fee = pool_data.fee * dy / FEE_DENOMINATOR;
        
        dy - fee
    }

    public fun get_dy_underlying(
        i: u64,
        j: u64,
        dx: u256,
        pool: &Object<TwoPool>, 
    ): u256 acquires TwoPool {
        let pool_data = pool_data<TwoPool>(pool);
        assert!(i != j && i < N_COINS && j < N_COINS, ERROR_INVALID_COIN_INDEX);

        let xp = xp(pool_data);
        let precisions = &pool_data.precision_muls;

        let x = *vector::borrow(&xp, i) + dx * *vector::borrow(precisions, i);
        let y = get_y(i, j, x, &xp, pool_data);
        let dy = (*vector::borrow(&xp, j) - y - 1) / *vector::borrow(precisions, j);

        let fee = pool_data.fee * dy / FEE_DENOMINATOR;
        dy - fee
    }

     public(friend) fun exchange(
        pool: &Object<TwoPool>,
        i: u64,
        j: u64,
        dx: FungibleAsset,
        min_dy: u256,
        sender: &signer,
    ): FungibleAsset acquires TwoPool {
        let pool_data = pool_data_mut<TwoPool>(pool);
        let pool_signer = &controller::get_signer();
        
        assert!(!pool_data.is_killed, ERROR_POOL_IS_KILLED);
        assert!(i != j && i < N_COINS && j < N_COINS, ERROR_INVALID_COIN_INDEX);

        let xp = xp(pool_data);
        let rates = &pool_data.rates;
        
        let x = *vector::borrow(&xp, i) + (fungible_asset::amount(&dx) as u256) * *vector::borrow(rates, i) / PRECISION;
        let y = get_y(i, j, x, &xp, pool_data);
        let dy = *vector::borrow(&xp, j) - y - 1;  // -1 to handle rounding errors
        let dy_fee = dy * pool_data.fee / FEE_DENOMINATOR;

        // Convert dy to token precision and check min_dy
        let dy_amount = (dy - dy_fee) * PRECISION / *vector::borrow(rates, j);
        assert!(dy_amount >= min_dy, ERROR_INSUFFICIENT_OUTPUT_AMOUNT);

        // Calculate admin fee
        let dy_admin_fee = dy_fee * pool_data.admin_fee / FEE_DENOMINATOR;
        dy_admin_fee = dy_admin_fee * PRECISION / *vector::borrow(rates, j);

        // Update balances
        *vector::borrow_mut(&mut pool_data.balances, i) = 
            *vector::borrow(&pool_data.balances, i) + (fungible_asset::amount(&dx) as u256);
        *vector::borrow_mut(&mut pool_data.balances, j) = 
            *vector::borrow(&pool_data.balances, j) - dy_amount - dy_admin_fee;

        // Perform the exchange
        let token_in_store = *vector::borrow(&pool_data.coins, i);
        let token_out_store = *vector::borrow(&pool_data.coins, j);
        let dx_amount = fungible_asset::amount(&dx);

        fungible_asset::deposit(token_in_store, dx);
        let output_asset = fungible_asset::withdraw(pool_signer, token_out_store, (dy_amount as u64));

        // Emit event
        event::emit(TokenExchangeEvent {
            buyer: signer::address_of(sender),
            sold_id: (i as u256),
            tokens_sold: (dx_amount as u256),
            bought_id: (j as u256),
            tokens_bought: (dy_amount as u256),
        });

        // return output to recipient
        output_asset
    }

    public(friend) fun remove_liquidity(
        pool: &Object<TwoPool>,
        lp_amount: FungibleAsset,
        min_amounts: vector<u256>,
        recipient: address,
    ): vector<FungibleAsset> acquires TwoPool {

        let pool_data = pool_data_mut<TwoPool>(pool);
        let pool_signer = &controller::get_signer();
        
        assert!(!pool_data.is_killed, ERROR_POOL_IS_KILLED);
        assert!(vector::length(&min_amounts) == N_COINS, ERROR_INVALID_AMOUNTS);

        let total_supply = (option::extract(&mut fungible_asset::supply(*pool)) as u256);
        let lp_amount_value = (fungible_asset::amount(&lp_amount) as u256);
        assert!(lp_amount_value > 0, ERROR_ZERO_AMOUNT);

        let amounts = vector::empty<u256>();
        let balances = &mut pool_data.balances;

        let withdrawn_assets = vector::empty<FungibleAsset>();

        let i = 0;
        while (i < N_COINS) {
            let amount = lp_amount_value * *vector::borrow(balances, i) / total_supply;
            assert!(amount >= *vector::borrow(&min_amounts, i), ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT);
            vector::push_back(&mut amounts, amount);

            // Withdraw tokens
            *vector::borrow_mut(balances, i) = *vector::borrow(balances, i) - amount;
            let token_store = *vector::borrow(&pool_data.coins, i);
            let asset = fungible_asset::withdraw(pool_signer, token_store, (amount as u64));
            vector::push_back(&mut withdrawn_assets, asset);
            i = i + 1;
        };

        // Burn LP tokens
        fungible_asset::burn(&pool_data.lp_token.burn_ref, lp_amount);

        // Emit event
        event::emit(RemoveLiquidityEvent {
            provider: recipient,
            token_amounts: amounts,
            token_supply: total_supply - lp_amount_value,
        });

        withdrawn_assets
    }

    public(friend) fun remove_liquidity_imbalance(
        pool: &Object<TwoPool>,
        amounts: vector<u256>,
        max_burn_amount: u256,
        recipient: address,
    ): vector<FungibleAsset> acquires TwoPool {
        let pool_data = pool_data_mut<TwoPool>(pool);
        let pool_signer = &controller::get_signer();
        let store = ensure_account_token_store(recipient, *pool);
        
        assert!(!pool_data.is_killed, ERROR_POOL_IS_KILLED);
        assert!(vector::length(&amounts) == N_COINS, ERROR_INVALID_AMOUNTS);

        let token_supply = (option::extract(&mut fungible_asset::supply(*pool)) as u256);
        assert!(token_supply > 0, ERROR_ZERO_TOTAL_SUPPLY);

        let fee = (pool_data.fee * (N_COINS as u256)) / (4 * (N_COINS - 1) as u256);
        let admin_fee = pool_data.admin_fee;
        let amp = get_a(pool_data);

        let old_balances = pool_data.balances;
        let new_balances = old_balances;
        let d0 = get_d_mem(&old_balances, amp, pool_data);
        
        for (i in 0..N_COINS) {
            *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) - *vector::borrow(&amounts, i);
        };

        let d1 = get_d_mem(&new_balances, amp, pool_data);
        assert!(d1 > 0, ERROR_INVALID_D);

        let fees = vector::empty<u256>();

        for (i in 0..N_COINS) {
            let ideal_balance = d1 * *vector::borrow(&old_balances, i) / d0;
            let difference = if (ideal_balance > *vector::borrow(&new_balances, i)) {
                ideal_balance - *vector::borrow(&new_balances, i)
            } else {
                *vector::borrow(&new_balances, i) - ideal_balance
            };
            *vector::borrow_mut(&mut fees, i) = fee * difference / FEE_DENOMINATOR;
            *vector::borrow_mut(&mut pool_data.balances, i) = *vector::borrow(&new_balances, i) - ((*vector::borrow(&fees, i) * admin_fee) / FEE_DENOMINATOR);
            *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) - *vector::borrow(&fees, i);
        };

        let d2 = get_d_mem(&new_balances, amp, pool_data);

        let burn_amount = ((d0 - d2) * token_supply) / d0;
        assert!(burn_amount > 0, ERROR_ZERO_AMOUNT);
        burn_amount = burn_amount + 1;
        assert!(burn_amount <= max_burn_amount, ERROR_EXCEED_MAX_BURN_AMOUNT);

        // Withdraw tokens
        let withdrawn_assets = vector::empty<FungibleAsset>();
        for (i in 0..N_COINS) {
            let amount = *vector::borrow(&amounts, i);
            if (amount > 0) {
                let token_store = *vector::borrow(&pool_data.coins, i);
                let asset = fungible_asset::withdraw(pool_signer, token_store, (amount as u64));
                vector::push_back(&mut withdrawn_assets, asset);
            };
        };

        // Burn LP tokens
        fungible_asset::burn_from(&pool_data.lp_token.burn_ref, store, (burn_amount as u64));

        // Emit event
        event::emit(RemoveLiquidityImbalanceEvent {
            provider: recipient,
            token_amounts: amounts,
            fees,
            inv: d2,
            token_supply: token_supply - burn_amount,
        });

        withdrawn_assets
    }

    /// Calculates x[i] if one reduces D from being calculated for xp to D
    /// Solves quadratic equation iteratively.
    /// x_1**2 + x_1 * (sum' - (A*n**n - 1) * D / (A * n**n)) = D ** (n + 1) / (n ** (2 * n) * prod' * A)
    /// x_1**2 + b*x_1 = c
    /// x_1 = (x_1**2 + c) / (2*x_1 + b)
    fun get_y_d(a: u256, token_index: u64, xp: &vector<u256>, d: u256): u256 {
        assert!(token_index < N_COINS, ERROR_INVALID_COIN_INDEX);
        let n_coins = (N_COINS as u256);
        let ann = a * n_coins;
        let c = d;
        let s = 0u256;

        for (i in 0..N_COINS) {
            if (i == token_index) {
                continue
            };
            let x = *vector::borrow(xp, (i as u64));
            s = s + x;
            c = c * d / (x * n_coins);
        };

        c = c * d / (ann * n_coins);
        let b = s + d / ann;
        let y = d;

        for (_i in 0..255) {
            let y_prev = y;
            y = (y*y + c) / (2 * y + b - d);
            if (y > y_prev) {
                if (y - y_prev <= 1) {
                    return y
                }
            } else {
                if (y_prev - y <= 1) {
                    return y
                }
            };
        };

        y
    }

    fun calc_withdraw_one_coin_internal (
        pool: &Object<TwoPool>,
        token_amount: u256,
        i: u64,
    ): (u256, u256) acquires TwoPool {
        let pool_data = pool_data<TwoPool>(pool);
        assert!(i < N_COINS, ERROR_INVALID_COIN_INDEX);

        let amp = get_a(pool_data);
        let xp = xp(pool_data);
        let d0 = get_d(&xp, amp);
        let precisions = &pool_data.precision_muls;

        let total_supply = (option::extract(&mut fungible_asset::supply(*pool)) as u256);
        let d1 = d0 - ((token_amount * d0) / total_supply);
        let new_y = get_y_d(amp, i, &xp, d1);
        let dy_0 = (*vector::borrow(&xp, i) - new_y) / *vector::borrow(precisions, i);

        let fee = (pool_data.fee * (N_COINS as u256)) / (4 * ((N_COINS - 1) as u256));

        let xp_reduced = xp;

        for (j in 0..N_COINS) {
            let dx_expected = if (j == i) {
                (*vector::borrow(&xp, j) * d1) / d0 - new_y
            } else {
                *vector::borrow(&xp, j) - ((*vector::borrow(&xp, j) * d1) / d0)
            };
            let x_reduced = *vector::borrow(&xp, j) - ((fee * dx_expected) / FEE_DENOMINATOR);
            *vector::borrow_mut(&mut xp_reduced, j) = x_reduced;
        };

        let dy = *vector::borrow(&xp_reduced, i) - get_y_d(amp, i, &xp_reduced, d1);
        dy = (dy - 1) / *vector::borrow(precisions, i);

        (dy, dy_0 - dy)
    }


    public fun calc_withdraw_one_coin(
        pool: &Object<TwoPool>,
        token_amount: u256,
        i: u64,
    ): (u256, u256) acquires TwoPool {
        let (dy, dy_fee) = calc_withdraw_one_coin_internal(pool, token_amount, i);
        (dy, dy_fee)
    }

    public(friend) fun remove_liquidity_one_coin(
        token_amount: u256,
        i: u64,
        min_amount: u256,
        provider: address,
        pool: &Object<TwoPool>
    ): FungibleAsset  acquires TwoPool {
        let (dy, dy_fee) = calc_withdraw_one_coin_internal(pool, token_amount, i);

        let pool_data = pool_data_mut(pool);
        let pool_signer = &controller::get_signer();
        assert!(!pool_data.is_killed, ERROR_POOL_IS_KILLED);
        let provider_coin_store = ensure_account_token_store(provider, *pool);

        assert!(dy >= min_amount, ERROR_INSUFFICIENT_COINS_REMOVED);

        let balances = &mut pool_data.balances;
        *vector::borrow_mut(balances, i) = *vector::borrow(balances, i) - ((dy_fee * pool_data.admin_fee) / FEE_DENOMINATOR);

        // burn lp token
        fungible_asset::burn_from(&pool_data.lp_token.burn_ref, provider_coin_store, (token_amount as u64));

        // extract coins
        let coins = fungible_asset::withdraw(pool_signer, *vector::borrow(&pool_data.coins, i), (dy as u64));

        event::emit(RemoveLiquidityOne{
            provider,
            index: i,
            coin_amount: dy,
            token_amount
        });

        coins
    }

    public(friend) fun ramp_a(admin: &signer, future_a: u256, future_time: u256, pool: &Object<TwoPool>) acquires TwoPool {

        controller::assert_admin(admin);

        let now = timestamp::now_seconds();
        let pool_data = pool_data_mut(pool);

        // Check if enough time has passed since the last ramp A
        assert!(now >= pool_data.initial_a_time + MIN_RAMP_TIME, ERROR_RAMP_A_IN_PROGRESS);
        // Check if the proposed ramp time is long enough
        assert!(future_time >= (now + (MIN_RAMP_TIME) as u256), ERROR_RAMP_TIME_TOO_SHORT);

        
        let initial_a = get_a(pool_data);
        assert!(future_a > 0 && future_a < MAX_A, ERROR_INVALID_A_VALUE);
        
        assert!(
            (future_a >= initial_a && future_a <= initial_a * MAX_A_CHANGE) ||
            (future_a < initial_a && future_a * MAX_A_CHANGE >= initial_a),
            ERROR_INVALID_A_VALUE
        );

        // Update the pool data
        pool_data.initial_a = initial_a;
        pool_data.future_a = future_a;
        pool_data.initial_a_time = now;
        pool_data.future_a_time = (future_time as u64);

        // Emit the RampA event
        event::emit(RampAEvent {
            old_a: initial_a,
            new_a: future_a,
            initial_time: now,
            future_time: (future_time as u64),
        });
        
    }
    
    public(friend) fun stop_rampget_a(admin: &signer, pool: &Object<TwoPool>) acquires TwoPool {

        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);
        let current_a = get_a(pool_data);
        let now = timestamp::now_seconds();

        pool_data.initial_a = current_a;
        pool_data.future_a = current_a;
        pool_data.initial_a_time = now;
        pool_data.future_a_time = now;

        event::emit(StopRampAEvent{a: current_a, t: now});
    }

    public(friend) fun commit_new_fee(
        admin: &signer,
        pool: &Object<TwoPool>,
        new_fee: u256,
        new_admin_fee: u256
    ) acquires TwoPool {

        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);

        // Validate new fees
        assert!(new_fee <= MAX_FEE, ERROR_FEE_TOO_HIGH);
        assert!(new_admin_fee <= MAX_ADMIN_FEE, ERROR_ADMIN_FEE_TOO_HIGH);
        assert!(pool_data.admin_actions_deadline == 0, ERROR_ADMIN_DEADLINE_NOT_ZERO);

        // Set the new fees and deadline
        let now = timestamp::now_seconds();
        pool_data.admin_actions_deadline = now + ADMIN_ACTIONS_DELAY;
        pool_data.future_fee = new_fee;
        pool_data.future_admin_fee = new_admin_fee;

        // Emit the CommitNewFee event
        event::emit(CommitNewFeeEvent {
            deadline: pool_data.admin_actions_deadline,
            new_fee,
            new_admin_fee,
        });
    }

    public(friend) fun apply_new_fee(
        admin: &signer,
        pool: &Object<TwoPool>
    ) acquires TwoPool {

        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);

        // Check if there's an active fee change and if enough time has passed
        assert!(pool_data.admin_actions_deadline != 0, ERROR_ADMIN_DEADLINE_IS_ZERO);
        assert!(timestamp::now_seconds() >= pool_data.admin_actions_deadline, ERROR_FEE_CHANGE_TOO_EARLY);

        // Apply the new fees
        pool_data.admin_actions_deadline = 0;
        pool_data.fee = pool_data.future_fee;
        pool_data.admin_fee = pool_data.future_admin_fee;

        // Emit the ApplyNewFee event
        event::emit(ApplyNewFeeEvent {
            new_fee: pool_data.fee,
            new_admin_fee: pool_data.admin_fee,
        });
    }

    public(friend) fun revert_new_parameters(admin: &signer, pool: &Object<TwoPool>) acquires TwoPool {
        
        controller::assert_admin(admin);
        
        let pool_data = pool_data_mut(pool);
        pool_data.admin_actions_deadline = 0;
        event::emit(RevertParameters{})
    }

    public(friend) fun withdraw_admin_fees(
        admin: &signer,
        pool: &Object<TwoPool>
    ): vector<FungibleAsset> acquires TwoPool {

        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);
        let pool_signer = &controller::get_signer();

        let withdrawn_assets = vector::empty<FungibleAsset>();
        let withdrawn_amounts = vector::empty<u256>();
        let total_withdrawn = 0u256;

        let i = 0;
        while (i < N_COINS) {
            let coin_balance = (fungible_asset::balance(*vector::borrow(&pool_data.coins, i)) as u256);
            let reported_balance = *vector::borrow(&pool_data.balances, i);
            
            if (coin_balance > reported_balance) {
                let admin_fee = coin_balance - reported_balance;
                if (admin_fee > 0) {
                    let coin_store = *vector::borrow(&pool_data.coins, i);
                    let withdrawn = fungible_asset::withdraw(pool_signer, coin_store, (admin_fee as u64));
                    vector::push_back(&mut withdrawn_assets, withdrawn);
                    vector::push_back(&mut withdrawn_amounts, admin_fee);
                    total_withdrawn = total_withdrawn + admin_fee;

                    // Update the reported balance
                    // *vector::borrow_mut(&mut pool_data.balances, i) = coin_balance;
                }
            };
            i = i + 1;
        };

        assert!(total_withdrawn > 0, ERROR_NO_ADMIN_FEES);

        withdrawn_assets
    }

    public(friend) fun kill_me(
        admin: &signer,
        pool: &Object<TwoPool>
    ) acquires TwoPool {

        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);

        // Check if the kill deadline has passed
        assert!(pool_data.kill_deadline > timestamp::now_seconds(), ERROR_KILL_DEADLINE_PASSED);

        // Check if the pool is already killed
        assert!(!pool_data.is_killed, ERROR_POOL_ALREADY_KILLED);

        // Kill the pool
        pool_data.is_killed = true;

        // Emit the Kill event
        event::emit(KillEvent {});
    }

    public(friend) fun unkill_me(
        admin: &signer,
        pool: &Object<TwoPool>
    ) acquires TwoPool {
        controller::assert_admin(admin);

        let pool_data = pool_data_mut(pool);

        // Check if the pool is killed
        assert!(pool_data.is_killed, ERROR_POOL_NOT_KILLED);

        // Unkill the pool
        pool_data.is_killed = false;

        // Emit the Unkill event
        event::emit(UnkillEvent {});
    }

    // Helper function for exponentiation
    fun pow(base: u256, exp: u64): u256 {
        let result = 1u256;
        let i = 0;
        while (i < exp) {
            result = result * base;
            i = i + 1;
        };
        result
    }

    public(friend) fun pool_coins<T: key>(pool: &Object<T>): vector<Object<FungibleStore>> acquires TwoPool {
       pool_data(pool).coins
    }


    public(friend) fun pool_fee<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).fee
    }

    public(friend) fun pool_admin_fee<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).admin_fee
    }

    public(friend) fun pool_initial_a<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).initial_a
    }

    public(friend) fun pool_future_a<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).future_a
    }

    public(friend) fun pool_initial_a_time<T: key>(pool: &Object<T>): u64 acquires TwoPool {
        pool_data(pool).initial_a_time
    }

    public(friend) fun pool_future_a_time<T: key>(pool: &Object<T>): u64 acquires TwoPool {
        pool_data(pool).future_a_time
    }

    public(friend) fun pool_kill_deadline<T: key>(pool: &Object<T>): u64 acquires TwoPool {
        pool_data(pool).kill_deadline
    }

    public(friend) fun pool_admin_actions_deadline<T: key>(pool: &Object<T>): u64 acquires TwoPool {
        pool_data(pool).admin_actions_deadline
    }

    public(friend) fun pool_future_fee<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).future_fee
    }

    public(friend) fun pool_future_admin_fee<T: key>(pool: &Object<T>): u256 acquires TwoPool {
        pool_data(pool).future_admin_fee
    }

    public(friend) fun pool_is_killed<T: key>(pool: &Object<T>): bool acquires TwoPool {
        pool_data(pool).is_killed
    }

    public(friend) fun pool_tokens<T: key>(pool: &Object<T>): (Object<Metadata>, Object<Metadata>) acquires TwoPool {
        let pool_data = pool_data(pool);
        (pool_data.token0, pool_data.token1)
    }

    public(friend) fun pool_balances<T: key>(pool: &Object<T>): vector<u256> acquires TwoPool {
        pool_data(pool).balances
    }

    public(friend) fun pool_precision_muls<T: key>(pool: &Object<T>): vector<u256> acquires TwoPool {
        pool_data(pool).precision_muls
    }

    public(friend) fun pool_rates<T: key>(pool: &Object<T>): vector<u256> acquires TwoPool {
        pool_data(pool).rates
    }

    public inline fun pool_data<T: key>(pool: &Object<T>): &TwoPool acquires TwoPool {
        borrow_global<TwoPool>(object::object_address(pool))
    }


    inline fun pool_data_mut<T: key>(pool: &Object<T>): &mut TwoPool acquires TwoPool {
        borrow_global_mut<TwoPool>(object::object_address(pool))
    }

    inline fun sum_vector(v: &vector<u256>): u256 {
        let sum = 0u256;
        let i = 0;
        while (i < vector::length(v)) {
            sum = sum + *vector::borrow(v, i);
            i = i + 1;
        };
        sum
    }

    inline fun create_lp_token(
        token0: Object<Metadata>,
        token1: Object<Metadata>
    ): &ConstructorRef {
        let token_name = lp_token_name(token0, token1);
        let seeds = get_pool_seeds(token0, token1);
        let lp_token_constructor_ref = &object::create_named_object(&controller::get_signer(), seeds);
        primary_fungible_store::create_primary_store_enabled_fungible_asset(
        lp_token_constructor_ref,
        option::none(),
        token_name,
        string::utf8(b"RAZOR LP"),
        LP_TOKEN_DECIMALS,
        string::utf8(b"https://ipfs.io/ipfs/QmYbAuxRGdSgNsfDopufzRrXsXfeuRsMnd1T1JR7qdi5Kn"),
        string::utf8(b"https://razordex.xyz"),
        );

        lp_token_constructor_ref
    }

    fun create_lp_token_refs(constructor_ref: &ConstructorRef): LPTokenRefs {
        LPTokenRefs {
            burn_ref: fungible_asset::generate_burn_ref(constructor_ref),
            mint_ref: fungible_asset::generate_mint_ref(constructor_ref),
            transfer_ref: fungible_asset::generate_transfer_ref(constructor_ref),
        }
    }

    fun ensure_account_token_store<T: key>(
        account: address, 
        pool: Object<T>
    ): Object<FungibleStore> {
        primary_fungible_store::ensure_primary_store_exists(account, pool);
        let store = primary_fungible_store::primary_store(account, pool);
        store
    }

    inline fun lp_token_name(token0: Object<Metadata>, token1: Object<Metadata>): String {
        let token_symbol = string::utf8(b"Razor ");
        string::append(&mut token_symbol, fungible_asset::symbol(token0));
        string::append_utf8(&mut token_symbol, b"-");
        string::append(&mut token_symbol, fungible_asset::symbol(token1));
        string::append_utf8(&mut token_symbol, b" LP");
        token_symbol
    }

    public fun get_pool_seeds(token0: Object<Metadata>, token1: Object<Metadata>): vector<u8> {
        let seeds = vector[];
        vector::append(&mut seeds, bcs::to_bytes(&object::object_address(&token0)));
        vector::append(&mut seeds, bcs::to_bytes(&object::object_address(&token1)));
        seeds
    }

    inline fun create_token_store(pool_signer: &signer, token: Object<Metadata>): Object<FungibleStore> {
        let constructor_ref = &object::create_object_from_object(pool_signer);
        fungible_asset::create_store(constructor_ref, token)
    }

    inline fun is_sorted(token0: Object<Metadata>, token1: Object<Metadata>): bool {
        let token0_addr = object::object_address(&token0);
        let token1_addr = object::object_address(&token1);
        comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
    }

    #[view]
    public fun lp_balance_of<T: key>(account: address, pool: Object<T>): u64 {
        primary_fungible_store::balance(account, pool)
    }

    #[view]
    public fun unpack_pool(pool: Object<TwoPool>): (Object<Metadata>, Object<Metadata>) acquires TwoPool {
        let pool = pool_data(&pool);
        (pool.token0, pool.token1)
    }

      #[view]
    public fun stable_swap_pool(
        token0: Object<Metadata>,
        token1: Object<Metadata>
    ): Object<TwoPool> {
        object::address_to_object(pool_address(token0, token1))
    }

    #[view]
    public fun stable_swap_pool_address_safe(
        token0: Object<Metadata>,
        token1: Object<Metadata>
    ): (bool, address) {
        let pool_address = pool_address(token0, token1);
        (exists<TwoPool>(pool_address), pool_address)
    }

    #[view]
    public fun pool_address(
        token0: Object<Metadata>,
        token1: Object<Metadata>
    ): address {
        if (!is_sorted(token0, token1)) {
            return pool_address(token1, token0)
        };
        object::create_object_address(&@razor_stable_swap, get_pool_seeds(token0, token1))
    }

}