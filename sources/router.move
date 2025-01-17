module razor_stable_swap::router {

    use std::vector;
    use std::signer;
    use aptos_framework::object::{Self, Object};
    use aptos_framework::fungible_asset::{Self, FungibleAsset, Metadata};
    use aptos_framework::primary_fungible_store;
    use aptos_framework::dispatchable_fungible_asset;

    use razor_stable_swap::three_pool::{Self, ThreePool};
    use razor_stable_swap::two_pool::{Self, TwoPool};
    use razor_stable_swap::router_helper;

    use razor_libs::token_utils;

    const TWO: u64 = 2;
    const THREE: u64 = 3;

    /// Invalid input lengths
    const ERROR_INVALID_VECTOR_LENGTH: u64 = 1;
    /// Excessive input amount
    const ERROR_EXCESSIVE_INPUT_AMOUNT: u64 = 2;

    fun num_coins(swap: address): u64 {
        if (object::object_exists<TwoPool>(swap)) {
            2
        } else if (object::object_exists<ThreePool>(swap)) {
            3
        } else {
            0
        }
    }

    inline fun add_liquidity_three(
        pool: Object<ThreePool>,
        amounts: vector<u64>,
        min_mint_amount: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);

        assert!(vector::length(&amounts) == THREE, ERROR_INVALID_VECTOR_LENGTH);
        let (token0, token1, token2) = three_pool::unpack_pool(pool);

        let asset0 = primary_fungible_store::withdraw(sender, token0, *vector::borrow(&amounts, 0));
        let asset1 = primary_fungible_store::withdraw(sender, token1, *vector::borrow(&amounts, 1));
        let asset2 = primary_fungible_store::withdraw(sender, token2, *vector::borrow(&amounts, 2));

        let token_vector = vector::empty<FungibleAsset>();
        vector::push_back(&mut token_vector, asset0);
        vector::push_back(&mut token_vector, asset1);
        vector::push_back(&mut token_vector, asset2);

        let lp_tokens = three_pool::add_liquidity(pool, token_vector, min_mint_amount, sender);

        let coin_store = token_utils::ensure_account_token_store(sender_addr, pool);

        dispatchable_fungible_asset::deposit(coin_store, lp_tokens);
    }

    inline fun add_liquidity_two(
        pool: Object<TwoPool>,
        amounts: vector<u64>,
        min_mint_amount: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);

        assert!(vector::length(&amounts) == TWO, ERROR_INVALID_VECTOR_LENGTH);

        let (token0, token1) = two_pool::unpack_pool(pool);
        
        let asset0 = primary_fungible_store::withdraw(sender, token0, *vector::borrow(&amounts, 0));
        let asset1 = primary_fungible_store::withdraw(sender, token1, *vector::borrow(&amounts, 1));

        let token_vector = vector::empty<FungibleAsset>();
        vector::push_back(&mut token_vector, asset0);
        vector::push_back(&mut token_vector, asset1);

        let lp_tokens = two_pool::add_liquidity(pool, token_vector, min_mint_amount, sender);

        let coin_store = token_utils::ensure_account_token_store(sender_addr, pool);

        dispatchable_fungible_asset::deposit(coin_store, lp_tokens);
    }

    inline fun remove_liquidity_three(
        lp_token_address: address,
        amount: u64,
        min_amounts: vector<u256>,
        sender: &signer
    ) {
        assert!(vector::length(&min_amounts) == THREE, ERROR_INVALID_VECTOR_LENGTH);

        let sender_addr = signer::address_of(sender);
        let lp_metadata = object::address_to_object<Metadata>(lp_token_address);
        let pool_object = object::address_to_object<ThreePool>(lp_token_address);


        let lp_token = fungible_asset::withdraw(sender, lp_metadata, amount);

        let withdrawn_assets = three_pool::remove_liquidity(&pool_object, lp_token, min_amounts, sender_addr);

        for (i in 0..vector::length(&withdrawn_assets)) {
            let fa = vector::pop_back(&mut withdrawn_assets);
            primary_fungible_store::deposit(sender_addr, fa);
        };

        vector::destroy_empty<FungibleAsset>(withdrawn_assets);
    }

    inline fun remove_liquidity_two(
        lp_token_address: address,
        amount: u64,
        min_amounts: vector<u256>,
        sender: &signer
    ) {
        assert!(vector::length(&min_amounts) == TWO, ERROR_INVALID_VECTOR_LENGTH);

        let sender_addr = signer::address_of(sender);
        let lp_metadata = object::address_to_object<Metadata>(lp_token_address);
        let pool_object = object::address_to_object<TwoPool>(lp_token_address);


        let lp_token = fungible_asset::withdraw(sender, lp_metadata, amount);

        let withdrawn_assets = two_pool::remove_liquidity(&pool_object, lp_token, min_amounts, sender_addr);

        for (i in 0..vector::length(&withdrawn_assets)) {
            let fa = vector::pop_back(&mut withdrawn_assets);
            primary_fungible_store::deposit(sender_addr, fa);
        };

        vector::destroy_empty<FungibleAsset>(withdrawn_assets);
    }

    inline fun remove_liquidity_imbalance_three(
        lp_token_address: address,
        amounts: vector<u256>,
        max_burn_amount: u256,
        sender: &signer
    ) {
        assert!(vector::length(&amounts) == THREE, ERROR_INVALID_VECTOR_LENGTH);

        let sender_addr = signer::address_of(sender);
        let pool_object = object::address_to_object<ThreePool>(lp_token_address);

        let withdrawn_assets = three_pool::remove_liquidity_imbalance(&pool_object, amounts, max_burn_amount, signer::address_of(sender));

        for (i in 0..vector::length(&withdrawn_assets)) {
            let fa = vector::pop_back(&mut withdrawn_assets);
            primary_fungible_store::deposit(sender_addr, fa);
        };

        vector::destroy_empty<FungibleAsset>(withdrawn_assets);

    }

    inline fun remove_liquidity_imbalance_two(
        lp_token_address: address,
        amounts: vector<u256>,
        max_burn_amount: u256,
        sender: &signer
    ) {
        assert!(vector::length(&amounts) == TWO, ERROR_INVALID_VECTOR_LENGTH);

        let sender_addr = signer::address_of(sender);
        let pool_object = object::address_to_object<TwoPool>(lp_token_address);

        let withdrawn_assets = two_pool::remove_liquidity_imbalance(&pool_object, amounts, max_burn_amount, signer::address_of(sender));

        for (i in 0..vector::length(&withdrawn_assets)) {
            let fa = vector::pop_back(&mut withdrawn_assets);
            primary_fungible_store::deposit(sender_addr, fa);
        };

        vector::destroy_empty<FungibleAsset>(withdrawn_assets);

    }

    inline fun remove_liquidity_one_coin_three(
        lp_token_address: address,
        amount: u256,
        i: u64,
        min_amount: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);
        let pool_object = object::address_to_object<ThreePool>(lp_token_address);
        
        let output_asset = three_pool::remove_liquidity_one_coin(amount, i, min_amount, sender_addr, &pool_object);

        primary_fungible_store::deposit(sender_addr, output_asset);
    }

    inline fun remove_liquidity_one_coin_two(
        lp_token_address: address,
        amount: u256,
        i: u64,
        min_amount: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);
        let pool_object = object::address_to_object<TwoPool>(lp_token_address);
        
        let output_asset = two_pool::remove_liquidity_one_coin(amount, i, min_amount, sender_addr, &pool_object);

        primary_fungible_store::deposit(sender_addr, output_asset);
    }

    fun exchange_three(
        pool: Object<ThreePool>,
        i: u64,
        j: u64,
        dx: FungibleAsset,
        min_dy: u256,
        sender: &signer
    ): FungibleAsset {
        let output_asset = three_pool::exchange(
            &pool, 
            i, 
            j, 
            dx, 
            min_dy, 
            sender
        );

        output_asset
    }

    fun exchange_two(
        pool: Object<TwoPool>,
        i: u64,
        j: u64,
        dx: FungibleAsset,
        min_dy: u256,
        sender: &signer
    ): FungibleAsset {
        let output_asset = two_pool::exchange(
            &pool, 
            i, 
            j, 
            dx, 
            min_dy, 
            sender
        );

        output_asset
    }

    inline fun ramp_a_three(
        pool: Object<ThreePool>,
        admin: &signer,
        future_a: u256,
        future_time: u256,
    ) {
        three_pool::ramp_a(admin, future_a, future_time, &pool);
    }

    inline fun ramp_a_two(
        pool: Object<TwoPool>,
        admin: &signer,
        future_a: u256,
        future_time: u256,
    ) {
        two_pool::ramp_a(admin, future_a, future_time, &pool);
    }

    inline fun stop_ramp_a_three(
        pool: Object<ThreePool>,
        admin: &signer,
    ) {
        three_pool::stop_rampget_a(admin, &pool);
    }

    inline fun stop_ramp_a_two(
        pool: Object<TwoPool>,
        admin: &signer,
    ) {
        two_pool::stop_rampget_a(admin, &pool);
    }

    inline fun commit_new_fee_three(
        pool: Object<ThreePool>,
        admin: &signer,
        new_fee: u256,
        new_admin_fee: u256
    ) {
        three_pool::commit_new_fee(admin, &pool, new_fee, new_admin_fee);
    }

    inline fun commit_new_fee_two(
        pool: Object<TwoPool>,
        admin: &signer,
        new_fee: u256,
        new_admin_fee: u256
    ) {
        two_pool::commit_new_fee(admin, &pool, new_fee, new_admin_fee);
    }

    inline fun apply_new_fee_three(
        admin: &signer,
        pool: Object<ThreePool>
    ) {
        three_pool::apply_new_fee(admin, &pool);
    }

    inline fun apply_new_fee_two(
        admin: &signer,
        pool: Object<TwoPool>
    ) {
        two_pool::apply_new_fee(admin, &pool);
    }

    inline fun revert_new_parameters_three(
        admin: &signer,
        pool: Object<ThreePool>
    ) {
        three_pool::revert_new_parameters(admin, &pool);
    }

    inline fun revert_new_parameters_two(
        admin: &signer,
        pool: Object<TwoPool>
    ) {
        two_pool::revert_new_parameters(admin, &pool);
    }

    inline fun withdraw_admin_fees_three(
        admin: &signer,
        pool: Object<ThreePool>
    ) {
        let fee_assets = three_pool::withdraw_admin_fees(admin, &pool);

        for (i in 0..THREE) {
            let fee_asset = vector::pop_back(&mut fee_assets);
            primary_fungible_store::deposit(signer::address_of(admin), fee_asset);
        };

        vector::destroy_empty<FungibleAsset>(fee_assets);
    }

    inline fun withdraw_admin_fees_two(
        admin: &signer,
        pool: Object<TwoPool>
    ) {
        let fee_assets = two_pool::withdraw_admin_fees(admin, &pool);

        for (i in 0..TWO) {
            let fee_asset = vector::pop_back(&mut fee_assets);
            primary_fungible_store::deposit(signer::address_of(admin), fee_asset);
        };

        vector::destroy_empty<FungibleAsset>(fee_assets);
    }

    inline fun kill_me_three(
        admin: &signer,
        pool: address
    ) {
        let pool_object = object::address_to_object<ThreePool>(pool);
        three_pool::kill_me(admin, &pool_object);
    }

    inline fun kill_me_two(
        admin: &signer,
        pool: address
    ) {
        let pool_object = object::address_to_object<TwoPool>(pool);
        two_pool::kill_me(admin, &pool_object);
    }

    inline fun unkill_me_three(
        admin: &signer,
        pool: address
    ) {
        let pool_object = object::address_to_object<ThreePool>(pool);
        three_pool::unkill_me(admin, &pool_object);
    }

    inline fun unkill_me_two(
        admin: &signer,
        pool: address
    ) {
        let pool_object = object::address_to_object<TwoPool>(pool);
        two_pool::unkill_me(admin, &pool_object);
    }

    fun exchange(
        pool: address,
        i: u64,
        j: u64,
        dx: FungibleAsset,
        min_dy: u256,
        sender: &signer
    ): FungibleAsset {
        let output_asset;
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            output_asset = exchange_two(pool_object, i, j, dx, min_dy, sender);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            output_asset = exchange_three(pool_object, i, j, dx, min_dy, sender);
        };

        output_asset
    }

    inline fun swap(
        path: vector<address>,
        flag: vector<u256>,
        amount_in: u64,
        min_amount_out: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);
        assert!(vector::length(&path) - 1 == vector::length(&flag), ERROR_INVALID_VECTOR_LENGTH);

        let i = 0;
        while (i < vector::length(&flag)) {
            let (input, output) = (*vector::borrow(&path, i), *vector::borrow(&path, i + 1));
            let (k, j, swap_contract) = router_helper::get_stable_info(input, output, *vector::borrow(&flag, i));
            let input_metadata = object::address_to_object<Metadata>(input);
            let dx = fungible_asset::withdraw(sender, input_metadata, amount_in);

            let min_dy = if (i == vector::length(&flag) - 1) {
                min_amount_out
            } else {
                0
            };

            let output_coin = exchange(swap_contract, k, j, dx, min_dy, sender);
            amount_in = fungible_asset::amount(&output_coin);

            if (i < vector::length(&flag) - 1) {
                let output_store = primary_fungible_store::ensure_primary_store_exists(sender_addr, object::address_to_object<Metadata>(output));
                fungible_asset::deposit(output_store, output_coin);
            } else {
                primary_fungible_store::deposit(sender_addr, output_coin);
            };

            i = i + 1;
        };
    }

    // ================================ ENTRY FUNCTIONS ================================

    public entry fun add_liquidity(
        pool: address,
        amounts: vector<u64>,
        min_mint_amount: u256,
        sender: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            add_liquidity_two(pool_object, amounts, min_mint_amount, sender);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            add_liquidity_three(pool_object, amounts, min_mint_amount, sender);
        }
    }

    public entry fun remove_liquidity(
        pool: address,
        amount: u64,
        min_amounts: vector<u256>,
        sender: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            remove_liquidity_two(pool, amount, min_amounts, sender);
        } else {
            remove_liquidity_three(pool, amount, min_amounts, sender);
        }
    }

    public entry fun remove_liquidity_imbalance(
        pool: address,
        amounts: vector<u256>,
        max_burn_amount: u256,
        sender: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            remove_liquidity_imbalance_two(pool, amounts, max_burn_amount, sender);
        } else {
            remove_liquidity_imbalance_three(pool, amounts, max_burn_amount, sender);
        }
    }

    public entry fun remove_liquidity_one_coin(
        pool: address,
        amount: u256,
        i: u64,
        min_amount: u256,
        sender: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            remove_liquidity_one_coin_two(pool, amount, i, min_amount, sender);
        } else {
            remove_liquidity_one_coin_three(pool, amount, i, min_amount, sender);
        }
    }

    public entry fun swap_exact_input(
        path: vector<address>,
        flag: vector<u256>,
        amount_in: u64,
        amount_out_min: u256,
        sender: &signer
    ) {
        swap(path, flag, amount_in, amount_out_min, sender);
    }

    public entry fun swap_exact_output(
        path: vector<address>,
        flag: vector<u256>,
        amount_out: u64,
        amount_in_max: u256,
        sender: &signer
    ) {
        let sender_addr = signer::address_of(sender);
        assert!(vector::length(&path) - 1 == vector::length(&flag), ERROR_INVALID_VECTOR_LENGTH);

        let amounts = router_helper::get_stable_amounts_in(path, flag, amount_out as u256);
        assert!(*vector::borrow(&amounts, 0) <= (amount_in_max as u256), ERROR_EXCESSIVE_INPUT_AMOUNT);

        let i = 0;
        while (i < vector::length(&flag)) {
            let (input, output) = (*vector::borrow(&path, i), *vector::borrow(&path, i + 1));
            let (k, j, swap_contract) = router_helper::get_stable_info(input, output, *vector::borrow(&flag, i));
            let input_metadata = object::address_to_object<Metadata>(input);
            let dx = fungible_asset::withdraw(sender, input_metadata, *vector::borrow(&amounts, i) as u64);

            let min_dy = if (i == vector::length(&flag) - 1) {
                amount_out as u256
            } else {
                *vector::borrow(&amounts, i + 1) as u256
            };

            let output_coin = exchange(swap_contract, k, j, dx, min_dy, sender);

            amount_out = fungible_asset::amount(&output_coin);

            if (i < vector::length(&flag) - 1) {
                let output_store = primary_fungible_store::ensure_primary_store_exists(sender_addr, object::address_to_object<Metadata>(output));
                fungible_asset::deposit(output_store, output_coin);
            } else {
                primary_fungible_store::deposit(sender_addr, output_coin);
            };

            i = i + 1;
        };

        // Refund excess input if necessary
        if (*vector::borrow(&amounts, 0) < (amount_in_max as u256)) {
            let refund_amount = amount_in_max - *vector::borrow(&amounts, 0);
            let input_metadata = object::address_to_object<Metadata>(*vector::borrow(&path, 0));
            primary_fungible_store::deposit(sender_addr, fungible_asset::withdraw(sender, input_metadata, refund_amount as u64));
        };
    }

    public entry fun ramp_a(
        pool: address,
        future_a: u256,
        future_time: u256,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            ramp_a_two(pool_object, admin, future_a, future_time);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            ramp_a_three(pool_object, admin, future_a, future_time);
        }
    }

    public entry fun stop_ramp_a(
        pool: address,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            stop_ramp_a_two(pool_object, admin);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            stop_ramp_a_three(pool_object, admin);
        }
    }

    public entry fun commit_new_fee(
        pool: address,
        new_fee: u256,
        new_admin_fee: u256,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            commit_new_fee_two(pool_object, admin, new_fee, new_admin_fee);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            commit_new_fee_three(pool_object, admin, new_fee, new_admin_fee);
        }
    }

    public entry fun apply_new_fee(
        pool: address,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            apply_new_fee_two(admin, pool_object);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            apply_new_fee_three(admin, pool_object);
        }
    }

    public entry fun revert_new_parameters(
        pool: address,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            revert_new_parameters_two(admin, pool_object);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            revert_new_parameters_three(admin, pool_object);
        }
    }

    public entry fun withdraw_admin_fees(
        pool: address,
        admin: &signer
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            let pool_object = object::address_to_object<TwoPool>(pool);
            withdraw_admin_fees_two(admin, pool_object);
        } else {
            let pool_object = object::address_to_object<ThreePool>(pool);
            withdraw_admin_fees_three(admin, pool_object);
        }
    }

    public entry fun kill_me(
        admin: &signer,
        pool: address
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            kill_me_two(admin, pool);
        } else {
            kill_me_three(admin, pool);
        }
    }

    public entry fun unkill_me(
        admin: &signer,
        pool: address
    ) {
        let n_coins = num_coins(pool);
        if (n_coins == 2) {
            unkill_me_two(admin, pool);
        } else {
            unkill_me_three(admin, pool);
        }
    }
}