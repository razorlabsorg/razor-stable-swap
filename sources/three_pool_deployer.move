module razor_stable_swap::three_pool_deployer {
  use std::vector;

  use aptos_framework::object::{Object};
  use aptos_framework::fungible_asset::Metadata;

  use razor_stable_swap::three_pool::{Self, ThreePool};

  use razor_libs::sort;

  friend razor_stable_swap::stable_swap_factory;

  const N_COINS: u64 = 3;

  /// Identical Addresses
  const ERROR_IDENTICAL_ADDRESSES: u64 = 1;

  public(friend) fun create_swap_pair(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
    tokenC: Object<Metadata>,
    a: u256,
    fee: u256,
    admin_fee: u256
  ): Object<ThreePool> {
    let (token0, token1, token2) = sort::sort_three_tokens(tokenA, tokenB, tokenC);
    let coins = vector::empty<Object<Metadata>>();
    vector::push_back(&mut coins, token0);
    vector::push_back(&mut coins, token1);
    vector::push_back(&mut coins, token2);
    let swap_contract = three_pool::initialize(coins, a, fee, admin_fee);
    return swap_contract
  }
}