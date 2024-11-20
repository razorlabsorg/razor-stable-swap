module razor_stable_swap::three_pool_deployer {
  use std::vector;
  use aptos_std::comparator;

  use aptos_framework::object::{Self, Object};
  use aptos_framework::fungible_asset::Metadata;

  use razor_stable_swap::stable_swap_errors;
  use razor_stable_swap::three_pool::{Self, ThreePool};

  friend razor_stable_swap::stable_swap_factory;

  const N_COINS: u64 = 3;

  fun is_sorted(token0: Object<Metadata>, token1: Object<Metadata>): bool {
    let token0_addr = object::object_address(&token0);
    let token1_addr = object::object_address(&token1);
    comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
  }

  fun sort_tokens(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
    tokenC: Object<Metadata>,
  ): (Object<Metadata>, Object<Metadata>, Object<Metadata>) {
    let tokenA_addr = object::object_address(&tokenA);
    let tokenB_addr = object::object_address(&tokenB);
    let tokenC_addr = object::object_address(&tokenC);
    assert!(tokenA_addr != tokenB_addr, stable_swap_errors::identical_addresses());
    assert!(tokenA_addr != tokenC_addr, stable_swap_errors::identical_addresses());
    assert!(tokenB_addr != tokenC_addr, stable_swap_errors::identical_addresses());
    let (token0, token1, token2);
    if (is_sorted(tokenA, tokenB)) {
      if (is_sorted(tokenB, tokenC)) {
        (token0, token1, token2) = (tokenA, tokenB, tokenC)
      } else {
        (token0, token1, token2) = (tokenA, tokenC, tokenB)
      }
    } else {
      if (is_sorted(tokenB, tokenC)) {
        (token0, token1, token2) = (tokenB, tokenA, tokenC)
      } else {
        (token0, token1, token2) = (tokenB, tokenC, tokenA)
      }
    };
    (token0, token1, token2)
  }

  public(friend) fun create_swap_pair(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
    tokenC: Object<Metadata>,
    a: u256,
    fee: u256,
    admin_fee: u256
  ): Object<ThreePool> {
    let (token0, token1, token2) = sort_tokens(tokenA, tokenB, tokenC);
    let coins = vector::empty<Object<Metadata>>();
    vector::push_back(&mut coins, token0);
    vector::push_back(&mut coins, token1);
    vector::push_back(&mut coins, token2);
    let swap_contract = three_pool::initialize(coins, a, fee, admin_fee);
    return swap_contract
  }
}