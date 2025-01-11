module razor_stable_swap::swap_library {
  use std::vector;

  use aptos_framework::object::{Self, Object};
  use aptos_framework::fungible_asset::{Metadata, FungibleStore};
  use aptos_framework::primary_fungible_store;

  use aptos_std::comparator;

  /// Identical Addresses
  const ERROR_IDENTICAL_ADDRESSES: u64 = 1;

  public fun is_sorted_two(token0: Object<Metadata>, token1: Object<Metadata>): bool {
    let token0_addr = object::object_address(&token0);
    let token1_addr = object::object_address(&token1);
    comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
  }

  public fun sort_tokens_two(
    tokenA: Object<Metadata>,
    tokenB: Object<Metadata>,
  ): vector<Object<Metadata>> {
    let tokenVector = vector::empty<Object<Metadata>>();
    vector::push_back(&mut tokenVector, tokenA);
    vector::push_back(&mut tokenVector, tokenB);

    let tokenA_addr = object::object_address(&tokenA);
    let tokenB_addr = object::object_address(&tokenB);
    assert!(tokenA_addr != tokenB_addr, ERROR_IDENTICAL_ADDRESSES);

    if (!is_sorted_two(tokenA, tokenB)) {
      vector::reverse(&mut tokenVector);
    } ;
    tokenVector
  }

  public fun sort_tokens_three(
    token0: Object<Metadata>,
    token1: Object<Metadata>,
    token2: Object<Metadata>,
  ): vector<Object<Metadata>> {
      let sorted = vector::empty<Object<Metadata>>();
      let addr0 = object::object_address(&token0);
      let addr1 = object::object_address(&token1);
      let addr2 = object::object_address(&token2);

      if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr1))) {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token1);
              vector::push_back(&mut sorted, token2);
          } else if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token1);
          } else {
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token0);
              vector::push_back(&mut sorted, token1);
          }
      } else {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
                  vector::push_back(&mut sorted, token1);
                  vector::push_back(&mut sorted, token0);
                  vector::push_back(&mut sorted, token2);
              } else {
                  vector::push_back(&mut sorted, token1);
                  vector::push_back(&mut sorted, token2);
                  vector::push_back(&mut sorted, token0);
              }
          } else {
              vector::push_back(&mut sorted, token2);
              vector::push_back(&mut sorted, token1);
              vector::push_back(&mut sorted, token0);
          }
      };

      sorted
  }

  public fun sort_tokens_position(
      token0: Object<Metadata>,
      token1: Object<Metadata>,
      token2: Object<Metadata>
  ): vector<u64> {
      let sorted = vector::empty<u64>();
      let addr0 = object::object_address(&token0);
      let addr1 = object::object_address(&token1);
      let addr2 = object::object_address(&token2);

      if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr1))) {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 1);
              vector::push_back(&mut sorted, 2);
          } else if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 1);
          } else {
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 0);
              vector::push_back(&mut sorted, 1);
          }
      } else {
          if (comparator::is_smaller_than(&comparator::compare(&addr1, &addr2))) {
              if (comparator::is_smaller_than(&comparator::compare(&addr0, &addr2))) {
                  vector::push_back(&mut sorted, 1);
                  vector::push_back(&mut sorted, 0);
                  vector::push_back(&mut sorted, 2);
              } else {
                  vector::push_back(&mut sorted, 1);
                  vector::push_back(&mut sorted, 2);
                  vector::push_back(&mut sorted, 0);
              }
          } else {
              vector::push_back(&mut sorted, 2);
              vector::push_back(&mut sorted, 1);
              vector::push_back(&mut sorted, 0);
          }
      };

      sorted
  }

  public fun ensure_account_token_store<T: key>(
    account: address, 
    pair: Object<T>
  ): Object<FungibleStore> {
    primary_fungible_store::ensure_primary_store_exists(account, pair);
    let store = primary_fungible_store::primary_store(account, pair);
    store
  }
}