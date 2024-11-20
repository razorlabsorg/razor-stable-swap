module razor_stable_swap::two_pool_deployer {
  use std::vector;
  use aptos_std::comparator;

  use aptos_framework::fungible_asset::Metadata;
  use aptos_framework::object::{Self, Object};

  use razor_stable_swap::stable_swap_errors;
  use razor_stable_swap::two_pool::{Self, TwoPool};

  friend razor_stable_swap::factory;

  const N_COINS: u64 = 2;

  fun is_sorted(token0: Object<Metadata>, token1: Object<Metadata>): bool {
    let token0_addr = object::object_address(&token0);
    let token1_addr = object::object_address(&token1);
    comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
  }

  // returns sorted token Metadata objects, used to handle return values from 
  // pairs sorted in this order
  fun sort_tokens(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
  ): (Object<Metadata>, Object<Metadata>) {
    let tokenA_addr = object::object_address(&tokenA);
    let tokenB_addr = object::object_address(&tokenB);
    assert!(tokenA_addr != tokenB_addr, stable_swap_errors::identical_addresses());
    let (token0, token1);
    if (is_sorted(tokenA, tokenB)) {
      (token0, token1) = (tokenA, tokenB)
    } else {
      (token0, token1) = (tokenB, tokenA)
    };

    (token0, token1)
  }

  public(friend) fun create_swap_pair(
    token0: Object<Metadata>,
    token1: Object<Metadata>,
    a: u256,
    fee: u256,
    admin_fee: u256,
  ): Object<TwoPool> {
    let (t0, t1) = sort_tokens(token0, token1);
    let coins = vector::empty<Object<Metadata>>();
    vector::push_back(&mut coins, t0);
    vector::push_back(&mut coins, t1);

    let swap_contract = two_pool::initialize(coins, a, fee, admin_fee);
    return swap_contract
  }
}