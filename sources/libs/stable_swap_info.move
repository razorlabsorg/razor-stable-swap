module razor_stable_swap::stable_swap_info {
  use std::vector;

  use aptos_framework::object;

  use razor_stable_swap::two_pool::{Self, TwoPool};
  use razor_stable_swap::three_pool::{Self, ThreePool};
  use razor_stable_swap::two_pool_info;
  use razor_stable_swap::three_pool_info;

  const FEE_DENOMINATOR: u256 = 10000000000; // 1e10

  fun num_coins(swap: address): u64 {
    if (object::object_exists<TwoPool>(swap)) {
      2
    } else if (object::object_exists<ThreePool>(swap)) {
      3
    } else {
      0
    }
  }

  #[view]
  public fun fee_denominator(): u256 {
    FEE_DENOMINATOR
  }

  #[view]
  public fun lp_token_supply(lp_token_address: address): u128 {
    let n_coins = num_coins(lp_token_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(lp_token_address);
      two_pool::lp_token_supply(pool)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(lp_token_address);
      three_pool::lp_token_supply(pool)
    } else {
      0
    }
  }

  #[view]
  public fun fee(swap_address: address): u256 {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool::fee(&pool)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool::fee(&pool)
    } else {
      0
    }
  }

  #[view]
  public fun get_dx(
    swap_address: address,
    i: u64,
    j: u64,
    dy: u256,
    max_dx: u256
  ): u256 {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool_info::get_dx(pool, i, j, dy, max_dx)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool_info::get_dx(pool, i, j, dy, max_dx)
    } else {
      0
    }
  }

  #[view]
  public fun get_dy(
    swap_address: address,
    i: u64,
    j: u64,
    dx: u256,
  ): u256 {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool_info::get_dy(i, j, dx, pool)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool_info::get_dy(i, j, dx, pool)
    } else {
      0
    }
  }

  #[view]
  public fun calc_coins_amount(
    swap_address: address,
    amount: u256
  ): vector<u256> {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool_info::calc_coins_amount(pool, amount)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool_info::calc_coins_amount(pool, amount)
    } else {
      vector::empty<u256>()
    }
  }

  #[view]
  public fun get_add_liquidity_mint_amount(
    swap_address: address,
    amounts: vector<u256>
  ): u256 {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool_info::get_add_liquidity_mint_amount(pool, amounts)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool_info::get_add_liquidity_mint_amount(pool, amounts)
    } else {
      0
    }
  }

  #[view]
  public fun get_exchange_fee(
    swap_address: address,
    i: u64,
    j: u64,
    dx: u256
  ): (u256, u256) {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool_info::get_exchange_fee(pool, i, j, dx)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool_info::get_exchange_fee(pool, i, j, dx)
    } else {
      (0, 0)
    }
  }

  #[view]
  public fun balances(swap_address: address): vector<u256> {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool::pool_balances(&pool)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool::pool_balances(&pool)
    } else {
      vector::empty<u256>()
    }
  }

  #[view]
  public fun a(swap_address: address): u256 {
    let n_coins = num_coins(swap_address);
    if (n_coins == 2) {
      let pool = object::address_to_object<TwoPool>(swap_address);
      two_pool::a(&pool)
    } else if (n_coins == 3) {
      let pool = object::address_to_object<ThreePool>(swap_address);
      three_pool::a(&pool)
    } else {
      0
    }
  }
}
