module razor_stable_swap::stable_swap_factory {
  use aptos_std::comparator;
  use aptos_std::simple_map::{Self, SimpleMap};

  use aptos_framework::event;
  use aptos_framework::object::{Self, Object};
  use aptos_framework::fungible_asset::Metadata;

  use razor_stable_swap::controller;
  use razor_stable_swap::two_pool::{Self, TwoPool};
  use razor_stable_swap::three_pool::{Self, ThreePool};
  use razor_stable_swap::two_pool_deployer;
  use razor_stable_swap::three_pool_deployer;
  use razor_stable_swap::stable_swap_errors;

  struct StableSwapPairInfo has copy, drop, store {
    swap_contract: address,
    token0: address,
    token1: address,
    lp_token: address
  }

  struct StableSwapThreePoolPairInfo has copy, drop, store {
    swap_contract: address,
    token0: address,
    token1: address,
    token2: address,
    lp_token: address
  }

  struct StableSwapFactory has key {
    stable_swap_pair_info: SimpleMap<address, SimpleMap<address, SimpleMap<address, StableSwapThreePoolPairInfo>>>,
    three_pool_info: SimpleMap<address, SimpleMap<address, StableSwapThreePoolPairInfo>>,
    swap_pair_contract: SimpleMap<u256, address>,
    pair_length: u256,
  }

  #[event]
  struct NewStableSwapPairEvent has drop, store {
    swap_contract: address,
    tokenA: address,
    tokenB: address,
    tokenC: address,
    lp_token: address
  }

  public entry fun initialize() {
    if (is_initialized()) {
      return
    };

    let pool_signer = &controller::get_signer();
    move_to(pool_signer, StableSwapFactory {
      stable_swap_pair_info: simple_map::new(),
      three_pool_info: simple_map::new(),
      swap_pair_contract: simple_map::new(),
      pair_length: 0
    });
  }

  #[view]
  public fun is_initialized(): bool {
    exists<StableSwapFactory>(@razor_stable_swap)
  }

  fun is_sorted(token0: Object<Metadata>, token1: Object<Metadata>): bool {
    let token0_addr = object::object_address(&token0);
    let token1_addr = object::object_address(&token1);
    comparator::is_smaller_than(&comparator::compare(&token0_addr, &token1_addr))
  }

  fun sort_two_tokens(
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

  fun sort_three_tokens(
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

  public entry fun create_swap_pair(
    sender: &signer,
    tokenA: address,
    tokenB: address,
    a: u256,
    fee: u256,
    admin_fee: u256
  ) acquires StableSwapFactory {
    controller::assert_admin(sender);
    let tokenA_object = object::address_to_object<Metadata>(tokenA);
    let tokenB_object = object::address_to_object<Metadata>(tokenB);
    let (t0, t1) = sort_two_tokens(tokenA_object, tokenB_object);
    let lp = two_pool_deployer::create_swap_pair(t0, t1, a, fee, admin_fee);
    let lp_address = object::object_address(&lp);
    add_pair_info_internal(
      lp_address, 
      object::object_address(&t0), 
      object::object_address(&t1), 
      @0x0, 
      lp_address
    );
  }

  public entry fun create_three_pool_pair(
    sender: &signer,
    tokenA: address,
    tokenB: address,
    tokenC: address,
    a: u256,
    fee: u256,
    admin_fee: u256
  ) acquires StableSwapFactory {
    controller::assert_admin(sender);
    let tokenA_object = object::address_to_object<Metadata>(tokenA);
    let tokenB_object = object::address_to_object<Metadata>(tokenB);
    let tokenC_object = object::address_to_object<Metadata>(tokenC);
    let (t0, t1, t2) = sort_three_tokens(tokenA_object, tokenB_object, tokenC_object);
    let lp = three_pool_deployer::create_swap_pair(t0, t1, t2, a, fee, admin_fee);
    let lp_address = object::object_address(&lp);
    add_pair_info_internal(
      lp_address, 
      object::object_address(&t0), 
      object::object_address(&t1), 
      object::object_address(&t2), 
      lp_address
    );
  }

  fun add_pair_info_internal(
    swap_contract: address,
    t0: address,
    t1: address,
    t2: address,
    lp: address
  ) acquires StableSwapFactory {
    let factory = borrow_global_mut<StableSwapFactory>(@razor_stable_swap);
    let first_map = *simple_map::borrow_mut(&mut factory.stable_swap_pair_info, &t0);
    let second_map = *simple_map::borrow_mut(&mut first_map, &t1);
    let info = *simple_map::borrow_mut(&mut second_map, &t2);
    info.swap_contract = swap_contract;
    info.token0 = t0;
    info.token1 = t1;
    info.token2 = t2;
    info.lp_token = lp;
    let pair_length = factory.pair_length;
    let swap_pair_contract = factory.swap_pair_contract;
    simple_map::add(&mut swap_pair_contract, pair_length, swap_contract);
    factory.pair_length = pair_length + 1;

    if (t2 != @0x0) {
      add_three_pool_pair_info(t0, t1, t2, info, factory.three_pool_info);
    };

    event::emit(NewStableSwapPairEvent {
      swap_contract: swap_contract,
      tokenA: t0,
      tokenB: t1,
      tokenC: t2,
      lp_token: lp
    })
  }

  fun add_three_pool_pair_info(
    t0: address,
    t1: address,
    t2: address,
    info: StableSwapThreePoolPairInfo,
    pool_info: SimpleMap<address, SimpleMap<address, StableSwapThreePoolPairInfo>>
  ) {
    let first_map = simple_map::new<address, StableSwapThreePoolPairInfo>();
    let second_map = simple_map::new<address, StableSwapThreePoolPairInfo>();
    let third_map = simple_map::new<address, StableSwapThreePoolPairInfo>();
    
    simple_map::add(&mut first_map, t1, info);
    simple_map::add(&mut pool_info, t0, first_map);
    simple_map::add(&mut second_map, t2, info);
    simple_map::add(&mut pool_info, t0, second_map);
    simple_map::add(&mut third_map, t2, info);
    simple_map::add(&mut pool_info, t1, third_map);
  }

  public entry fun add_pair_info(
    sender: &signer, 
    swap_contract: address,
  ) acquires StableSwapFactory {
    controller::assert_admin(sender);
    let n_coins = num_coins(swap_contract);
    if (n_coins == 2) {
      let swap_object = object::address_to_object<TwoPool>(swap_contract);
      let (token0, token1) = two_pool::pool_tokens(&swap_object);
      add_pair_info_internal(
        swap_contract, 
        object::object_address(&token0), 
        object::object_address(&token1), 
        @0x0, 
        swap_contract
      );
    } else if (n_coins == 3) {
      let swap_object = object::address_to_object<ThreePool>(swap_contract);
      let (token0, token1, token2) = three_pool::pool_tokens(&swap_object);
      add_pair_info_internal(
        swap_contract, 
        object::object_address(&token0), 
        object::object_address(&token1), 
        object::object_address(&token2), 
        swap_contract
      );
    }
  }

  #[view]
  public fun get_pair_info(tokenA: address, tokenB: address): StableSwapPairInfo  acquires StableSwapFactory {
    let tokenA_object = object::address_to_object<Metadata>(tokenA);
    let tokenB_object = object::address_to_object<Metadata>(tokenB);
    let (t0, t1) = sort_two_tokens(tokenA_object, tokenB_object);
    let factory = borrow_global<StableSwapFactory>(@razor_stable_swap);
    let map = *simple_map::borrow(&factory.stable_swap_pair_info, &object::object_address(&t0));
    let map_inner = *simple_map::borrow(&map, &object::object_address(&t1));
    let info = *simple_map::borrow(&map_inner, &@0x0);

    let result = StableSwapPairInfo {
      swap_contract: info.swap_contract,
      token0: info.token0,
      token1: info.token1,
      lp_token: info.lp_token
    };

    result
  }

  public fun deconstruct_pair_info(
    info: StableSwapPairInfo
  ): (address, address, address, address) {
    (
      info.swap_contract, 
      info.token0, 
      info.token1, 
      info.lp_token
    )
  }

  #[view]
  public fun get_three_pool_pair_info(tokenA: address, tokenB: address): StableSwapThreePoolPairInfo  acquires StableSwapFactory {
    let tokenA_object = object::address_to_object<Metadata>(tokenA);
    let tokenB_object = object::address_to_object<Metadata>(tokenB);
    let (t0, t1) = sort_two_tokens(tokenA_object, tokenB_object);
    let factory = borrow_global<StableSwapFactory>(@razor_stable_swap);
    let map = *simple_map::borrow(&factory.three_pool_info, &object::object_address(&t0));
    let info = *simple_map::borrow(&map, &object::object_address(&t1));
    info
  }

  public fun deconstruct_three_pool_pair_info(
    info: StableSwapThreePoolPairInfo
  ): (address, address, address, address, address) {
    (
      info.swap_contract, 
      info.token0, 
      info.token1, 
      info.token2, 
      info.lp_token
    )
  }

  fun num_coins(swap_address: address): u64 {
    if (object::object_exists<TwoPool>(swap_address)) {
      2
    } else if (object::object_exists<ThreePool>(swap_address)) {
      3
    } else {
      0
    }
  }

  public entry fun pause(account: &signer) {
    controller::pause(account);
  }

  public entry fun unpause(account: &signer) {
    controller::unpause(account);
  }

  public entry fun set_admin(account: &signer, admin: address) {
    controller::set_admin_address(account, admin);
  }

  public entry fun claim_admin(account: &signer) {
    controller::claim_admin(account);
  }

  #[test_only]
  public fun init_for_testing() {
    initialize();
  }
}