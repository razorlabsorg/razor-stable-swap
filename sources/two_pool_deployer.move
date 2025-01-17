module razor_stable_swap::two_pool_deployer {
  use std::vector;

  use aptos_framework::fungible_asset::Metadata;
  use aptos_framework::object::{Object};

  use razor_stable_swap::two_pool::{Self, TwoPool};

  use razor_libs::sort;

  friend razor_stable_swap::factory;

  public(friend) fun create_swap_pair(
    token0: Object<Metadata>,
    token1: Object<Metadata>,
    a: u256,
    fee: u256,
    admin_fee: u256,
  ): Object<TwoPool> {
    let (t0, t1) = sort::sort_two_tokens(token0, token1);
    let coins = vector::empty<Object<Metadata>>();
    vector::push_back(&mut coins, t0);
    vector::push_back(&mut coins, t1);

    let swap_contract = two_pool::initialize(coins, a, fee, admin_fee);
    return swap_contract
  }
}