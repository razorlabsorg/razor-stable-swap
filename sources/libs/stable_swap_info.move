module razor_stable_swap::stable_swap_info {
  use std::vector;

  use aptos_framework::object;

  use razor_stable_swap::two_pool::{TwoPool};
  use razor_stable_swap::three_pool::{ThreePool};
  use razor_stable_swap::two_pool_info;
  use razor_stable_swap::three_pool_info;

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
}
