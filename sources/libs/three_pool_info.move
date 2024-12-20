module razor_stable_swap::three_pool_info {
    use std::vector;
    use std::option;

    use aptos_framework::object::{Self, Object};
    use aptos_framework::fungible_asset::{Self, Metadata};

    use razor_stable_swap::three_pool::{Self, ThreePool};

    // Constants
    const N_COINS: u64 = 3;
    const FEE_DENOMINATOR: u256 = 10000000000; // 1e10
    const PRECISION: u256 = 1000000000000000000; // 1e18

    // Errors
    /// Invalid coin index
    const ERROR_INVALID_COIN_INDEX: u64 = 1;
    /// Fewer coins in exchange
    const ERROR_FEWER_COINS_IN_EXCHANGE: u64 = 2;
    /// Excess balance
    const ERROR_EXCESS_BALANCE: u64 = 3;
    /// D1 must be greater than D0
    const ERROR_D1_MUST_BE_GREATER_THAN_D0: u64 = 4;
    /// Initial deposit requires all coins
    const ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS: u64 = 5;

    #[view]
    public fun fee_denominator(): u256 {
        FEE_DENOMINATOR
    }

    #[view]
    public fun token(pool: Object<ThreePool>): address {
        let (t0, t1, t2) = three_pool::unpack_pool(pool);
        let pool_token_address = three_pool::pool_address(t0, t1, t2);
        pool_token_address
    }

    #[view]
    public fun lp_token_supply(pool: Object<ThreePool>): u128 {
        three_pool::lp_token_supply(pool)
    }

    #[view]
    public fun fee(pool: Object<ThreePool>): u256 {
        three_pool::fee(&pool)
    }

    #[view]
    public fun a(pool: Object<ThreePool>): u256 {
        three_pool::a(&pool)
    }

    #[view]
    public fun balances(pool: Object<ThreePool>): vector<u256> {
        three_pool::pool_balances(&pool)
    }

    #[view]
    public fun rates(pool: Object<ThreePool>): vector<u256> {
        three_pool::pool_rates(&pool)
    }

    #[view]
    public fun balance_from_token_address(pool: Object<ThreePool>, token_address: address): u256 {
        let balances = balances(pool);
        let coins = three_pool::pool_coins(&pool);
        let i = 0;
        while (i < N_COINS) {
            
            let coin_metadata = fungible_asset::store_metadata(*vector::borrow(&coins, i));
            let input_metadata = object::address_to_object<Metadata>(token_address);
            if (coin_metadata == input_metadata) {
                return *vector::borrow(&balances, i)
            };
            i = i + 1;
        };
        (0 as u256)
    }

    #[view]
    public fun balances_with_positions(pool: Object<ThreePool>, positions: vector<address>): vector<u256> {
        let balances_with_positions = vector::empty<u256>();
        let i = 0;
        while (i < vector::length(&positions)) {
            let token_address = *vector::borrow(&positions, i);
            let balance = balance_from_token_address(pool, token_address);
            vector::push_back(&mut balances_with_positions, balance);
            i = i + 1;
        };
        balances_with_positions
    }

    #[view]
    public fun precision_mul(pool: Object<ThreePool>): vector<u256> {
        let precision_muls = vector::empty<u256>();
        let (token0, token1, token2) = three_pool::unpack_pool(pool);
        let tokens = vector[token0, token1, token2];
        let i = 0;
        while (i < N_COINS) {
            let token = *vector::borrow(&tokens, i);
            let decimals = fungible_asset::decimals(token);
            let precision_mul = pow(10, (8 - (decimals as u64)));
            vector::push_back(&mut precision_muls, precision_mul);
            i = i + 1;
        };
        precision_muls
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

    #[view]
    public fun calc_coins_amount(pool: Object<ThreePool>, amount: u256): vector<u256> {
        let total_supply = (option::extract(&mut fungible_asset::supply(pool)) as u256);
        let balances = balances(pool);
        let amounts = vector::empty<u256>();

        let i = 0;
        while (i < N_COINS) {
            let value = (*vector::borrow(&balances, i) * amount) / total_supply;
            vector::push_back(&mut amounts, value);
            i = i + 1;
        };
        amounts
    }

    #[view]
    public fun get_d_mem(pool: Object<ThreePool>, balances: vector<u256>, amp: u256): u256 {
        let xp = xp_mem(balances, pool);
        three_pool::get_d(&xp, amp)
    }

    #[view]
    public fun get_add_liquidity_mint_amount(pool: Object<ThreePool>, amounts: vector<u256>): u256 {
        let pool_fee = three_pool::pool_fee(&pool);
        let fee = (pool_fee * (N_COINS as u256)) / (4 * ((N_COINS - 1) as u256));
        let amp = three_pool::a(&pool);

        let token_supply = (option::extract(&mut fungible_asset::supply(pool)) as u256);
        let old_balances = balances(pool);
        let d0 = if (token_supply > 0) {
            get_d_mem(pool, old_balances, amp)
        } else {
            0
        };

        let new_balances = old_balances;
        let i = 0;
        while (i < N_COINS) {
            if (token_supply == 0) {
                assert!(*vector::borrow(&amounts, i) > 0, 0); // Initial deposit requires all coins
            };
            let new_balance = *vector::borrow(&old_balances, i) + *vector::borrow(&amounts, i);
            *vector::borrow_mut(&mut new_balances, i) = new_balance;
            i = i + 1;
        };

        let d1 = get_d_mem(pool, new_balances, amp);
        assert!(d1 > d0, 0); // D1 must be greater than D0

        let d2 = d1;
        if (token_supply > 0) {
            let fees = vector::empty<u256>();
            i = 0;
            while (i < N_COINS) {
                let ideal_balance = (d1 * *vector::borrow(&old_balances, i)) / d0;
                let difference = if (ideal_balance > *vector::borrow(&new_balances, i)) {
                    ideal_balance - *vector::borrow(&new_balances, i)
                } else {
                    *vector::borrow(&new_balances, i) - ideal_balance
                };
                let fee_amount = (fee * difference) / FEE_DENOMINATOR;
                vector::push_back(&mut fees, fee_amount);
                *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) - fee_amount;
                i = i + 1;
            };
            d2 = get_d_mem(pool, new_balances, amp);
        };

        let mint_amount = if (token_supply == 0) {
            d1
        } else {
            (token_supply * (d2 - d0)) / d0
        };

        mint_amount
    }

    fun xp_mem(balances: vector<u256>, pool: Object<ThreePool>): vector<u256> {
        let rates = three_pool::pool_rates(&pool);

        let result = vector::empty<u256>();
        let i = 0;
        while (i < N_COINS) {
            let balance = *vector::borrow(&balances, i);
            let rate = *vector::borrow(&rates, i);
            vector::push_back(&mut result, balance * rate / PRECISION);
            i = i + 1;
        };
        result
    }

    #[view]
    public fun get_add_liquidity_fee(pool: Object<ThreePool>, amounts: vector<u256>): vector<u256> {
        let pool_fee = three_pool::pool_fee(&pool);
        let fee = (pool_fee * (N_COINS as u256)) / (4 * ((N_COINS - 1) as u256));
        let admin_fee = three_pool::pool_admin_fee(&pool);
        let amp = three_pool::a(&pool);

        let token_supply = (option::extract(&mut fungible_asset::supply(pool)) as u256);
        let old_balances = balances(pool);
        let d0 = if (token_supply > 0) {
            get_d_mem(pool, old_balances, amp)
        } else {
            0
        };

        let new_balances = old_balances;
        let i = 0;
        while (i < N_COINS) {
            if (token_supply == 0) {
                assert!(*vector::borrow(&amounts, i) > 0, ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS); // Initial deposit requires all coins
            };
            let new_balance = *vector::borrow(&old_balances, i) + *vector::borrow(&amounts, i);
            *vector::borrow_mut(&mut new_balances, i) = new_balance;
            i = i + 1;
        };

        let d1 = get_d_mem(pool, new_balances, amp);
        assert!(d1 > d0, ERROR_D1_MUST_BE_GREATER_THAN_D0); // D1 must be greater than D0

        let liquidity_fee = vector::empty<u256>();
        if (token_supply > 0) {
            i = 0;
            while (i < N_COINS) {
                let ideal_balance = (d1 * *vector::borrow(&old_balances, i)) / d0;
                let difference = if (ideal_balance > *vector::borrow(&new_balances, i)) {
                    ideal_balance - *vector::borrow(&new_balances, i)
                } else {
                    *vector::borrow(&new_balances, i) - ideal_balance
                };
                let coin_fee = (fee * difference) / FEE_DENOMINATOR;
                let fee_amount = ((coin_fee * admin_fee) / FEE_DENOMINATOR);
                vector::push_back(&mut liquidity_fee, fee_amount);
                i = i + 1;
            };
        } else {
            // If token_supply is 0, there are no fees
            vector::push_back(&mut liquidity_fee, 0);
            vector::push_back(&mut liquidity_fee, 0);
            vector::push_back(&mut liquidity_fee, 0);
        };

        liquidity_fee
    }

    #[view]
    public fun get_remove_liquidity_imbalance_fee(pool: Object<ThreePool>, amounts: vector<u256>): vector<u256> {
        let pool_fee = three_pool::pool_fee(&pool);
        let fee = (pool_fee * (N_COINS as u256)) / (4 * ((N_COINS - 1) as u256));
        let admin_fee = three_pool::pool_admin_fee(&pool);
        let amp = three_pool::a(&pool);

        let old_balances = balances(pool);
        let new_balances = old_balances;
        let d0 = get_d_mem(pool, old_balances, amp);

        let i = 0;
        while (i < N_COINS) {
            *vector::borrow_mut(&mut new_balances, i) = *vector::borrow(&new_balances, i) - *vector::borrow(&amounts, i);
            i = i + 1;
        };

        let d1 = get_d_mem(pool, new_balances, amp);

        let liquidity_fee = vector::empty<u256>();
        i = 0;
        while (i < N_COINS) {
            let ideal_balance = (d1 * *vector::borrow(&old_balances, i)) / d0;
            let difference = if (ideal_balance > *vector::borrow(&new_balances, i)) {
                ideal_balance - *vector::borrow(&new_balances, i)
            } else {
                *vector::borrow(&new_balances, i) - ideal_balance
            };
            let coin_fee = (fee * difference) / FEE_DENOMINATOR;
            let fee_amount = ((coin_fee * admin_fee) / FEE_DENOMINATOR);
            vector::push_back(&mut liquidity_fee, fee_amount);
            i = i + 1;
        };

        liquidity_fee
    }

    #[view]
    public fun get_exchange_fee(
        pool: Object<ThreePool>,
        i: u64,
        j: u64,
        dx: u256
    ): (u256, u256) {
        assert!(i < N_COINS && j < N_COINS && i != j, ERROR_INVALID_COIN_INDEX);

        let pool_fee = three_pool::pool_fee(&pool);
        let admin_fee = three_pool::pool_admin_fee(&pool);
        let amp = three_pool::a(&pool);

        let old_balances = balances(pool);
        let xp = xp_mem(old_balances, pool);
        let rates = three_pool::pool_rates(&pool);

        let x = *vector::borrow(&xp, i) + (dx * *vector::borrow(&rates, i)) / PRECISION;
        let y = get_y(i, j, x, &xp, amp);

        let dy = *vector::borrow(&xp, j) - y - 1; // -1 just in case there were some rounding errors
        let dy_fee = (dy * pool_fee) / FEE_DENOMINATOR;

        let dy_admin_fee = (dy_fee * admin_fee) / FEE_DENOMINATOR;
        let ex_fee = (dy_fee * PRECISION) / *vector::borrow(&rates, j);
        let ex_admin_fee = (dy_admin_fee * PRECISION) / *vector::borrow(&rates, j);

        (ex_fee, ex_admin_fee)
    }

    // Helper function to calculate y
    fun get_y(
        i: u64,
        j: u64,
        x: u256,
        xp: &vector<u256>,
        amp: u256
    ): u256 {
        assert!(i != j && i < N_COINS && j < N_COINS, ERROR_INVALID_COIN_INDEX);
        let amp_n = amp * (N_COINS as u256);
        let d = three_pool::get_d(xp, amp);
        let c = d;
        let s = 0u256;
        let n = (N_COINS as u256);

        let _x = 0u256;
        let y_prev: u256;
        let y = d;

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

        c = c * d * PRECISION / (amp_n * n);
        let b = s + d * PRECISION / amp_n;

        // Iterate to find y
        for (_i in 0..255) {
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

        y // Return the last calculated y if the loop doesn't converge
    }

    #[view]
    public fun get_remove_liquidity_one_coin_fee(
        pool: Object<ThreePool>,
        token_amount: u256,
        i: u64
    ): u256 {
        assert!(i < N_COINS, ERROR_INVALID_COIN_INDEX);

        let admin_fee = three_pool::pool_admin_fee(&pool);
        let (_, dy_fee) = three_pool::calc_withdraw_one_coin(&pool, token_amount, i);
        (dy_fee * admin_fee) / FEE_DENOMINATOR
    }

    #[view]
    public fun get_dx(
        pool: Object<ThreePool>,
        i: u64,
        j: u64,
        dy: u256,
        max_dx: u256
    ): u256 {
        assert!(i < N_COINS && j < N_COINS && i != j, ERROR_INVALID_COIN_INDEX);

        let pool_fee = three_pool::pool_fee(&pool);
        let old_balances = balances(pool);
        let xp = xp_mem(old_balances, pool);
        let rates = three_pool::pool_rates(&pool);
        let amp = three_pool::a(&pool);

        let dy_with_fee = (dy * FEE_DENOMINATOR) / (FEE_DENOMINATOR - pool_fee);
        assert!(dy_with_fee < *vector::borrow(&old_balances, j), ERROR_EXCESS_BALANCE);

        let y = *vector::borrow(&xp, j) - (dy_with_fee * *vector::borrow(&rates, j)) / PRECISION;
        let x = get_y(j, i, y, &xp, amp);

        let dx = x - *vector::borrow(&xp, i);

        // Convert to real units
        let dx = (dx * PRECISION) / *vector::borrow(&rates, i) + 1; // +1 for round loss
        assert!(dx <= max_dx, ERROR_FEWER_COINS_IN_EXCHANGE);

        dx
    }

    #[view]
    public fun get_dy(
        i: u64,
        j: u64,
        dx: u256,
        pool: Object<ThreePool>
    ): u256 {
        three_pool::get_dy(i, j, dx, &pool)
    }
}