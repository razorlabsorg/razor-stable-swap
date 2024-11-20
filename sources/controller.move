// This module is responsible for housekeeping
module razor_stable_swap::controller {
  use std::signer;

  use aptos_framework::object::{Self, ExtendRef};

  friend razor_stable_swap::three_pool;
  friend razor_stable_swap::two_pool;
  friend razor_stable_swap::factory;

  const FEE_ADMIN: address = @fee_admin;
  const ADMIN: address = @admin;

  /// No operations are allowed when contract is paused
  const ERROR_PAUSED: u64 = 1;
  /// Contract is needs to be paused first
  const ERROR_UNPAUSED: u64 = 2;
  /// Operation is not allowed
  const ERROR_FORBIDDEN: u64 = 3;
  /// No Pending Admin
  const ERROR_NO_PENDING_ADMIN: u64 = 4;
  /// Invalid Address
  const ERROR_INVALID_ADDRESS: u64 = 5;
  /// Pending Admin Exists
  const ERROR_PENDING_ADMIN_EXISTS: u64 = 6;

  struct StableSwapConfig has key {
    extend_ref: ExtendRef,
    fee_to: address,
    current_admin: address,
    pending_admin: address,
    fee_on: bool,
    paused: bool,
  }

  fun init_module(deployer: &signer) {
    let constructor_ref = object::create_object(@razor_stable_swap);
    let extend_ref = object::generate_extend_ref(&constructor_ref);

    move_to(deployer, StableSwapConfig {
      extend_ref,
      fee_to: FEE_ADMIN,
      current_admin: ADMIN,
      pending_admin: @0x0,
      fee_on: true,
      paused: false
    })
  }

  public(friend) fun get_signer(): signer acquires StableSwapConfig {
    let ref = &stable_swap_config().extend_ref;
    object::generate_signer_for_extending(ref)
  }

  #[view]
  public fun get_signer_address(): address acquires StableSwapConfig {
    signer::address_of(&get_signer())
  }

  #[view]
  public fun get_fee_to(): address acquires StableSwapConfig {
    stable_swap_config().fee_to
  }

  #[view]
  public fun get_admin(): address acquires StableSwapConfig {
    stable_swap_config().current_admin
  }

  #[view]
  public fun get_fee_on(): bool acquires StableSwapConfig {
    stable_swap_config().fee_on
  }

  /// Asserts that the protocol is in paused state
  /// Aborts if protocol is not paused
  public fun assert_paused() acquires StableSwapConfig {
    assert!(stable_swap_config().paused == true, ERROR_PAUSED);
  }

  /// Asserts that the protocol is not paused
  /// Aborts if protocol is paused
  public fun assert_unpaused() acquires StableSwapConfig {
    assert!(stable_swap_config().paused == false, ERROR_UNPAUSED);
  }

  public fun assert_admin(account: &signer) acquires StableSwapConfig {
    assert!(stable_swap_config().current_admin == signer::address_of(account), ERROR_FORBIDDEN);
  }

  /// Pauses the protocol
  /// Can only be called by the current admin
  public(friend) fun pause(account: &signer) acquires StableSwapConfig {
    assert_unpaused();
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.paused = true;
  }

  /// Unpauses the protocol
  /// Can only be called by the current admin
  public(friend) fun unpause(account: &signer) acquires StableSwapConfig {
    assert_paused();
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.paused = false;
  }

  public(friend) fun set_fee_to(
    account: &signer,
    fee_to: address
  ) acquires StableSwapConfig {
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.fee_to = fee_to;
  }

  public(friend) fun set_admin_address(
    account: &signer,
    admin_address: address
  ) acquires StableSwapConfig {
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    assert!(admin_address != @0x0, ERROR_INVALID_ADDRESS);  // Add new error check
    assert!(swap_config.pending_admin == @0x0, ERROR_PENDING_ADMIN_EXISTS);  // Add new error check
    swap_config.pending_admin = admin_address;
  }

  public(friend) fun claim_admin(
    account: &signer
  ) acquires StableSwapConfig {
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    let account_addr = signer::address_of(account);
    assert!(account_addr == swap_config.pending_admin, ERROR_FORBIDDEN);
    assert!(swap_config.pending_admin != @0x0, ERROR_NO_PENDING_ADMIN);  // Add new error check
    swap_config.current_admin = account_addr;
    swap_config.pending_admin = @0x0;
  }

  inline fun stable_swap_config(): &StableSwapConfig acquires StableSwapConfig {
    borrow_global<StableSwapConfig>(@razor_stable_swap)
  }

  #[test_only]
  public fun initialize_for_test(admin: &signer) {
    let admin_addr = std::signer::address_of(admin);
    if (!exists<StableSwapConfig>(admin_addr)) {
      aptos_framework::timestamp::set_time_has_started_for_testing(&aptos_framework::account::create_signer_for_test(@0x1));

      aptos_framework::account::create_account_for_test(admin_addr);
      
      let constructor_ref = object::create_object(admin_addr);
      let extend_ref = object::generate_extend_ref(&constructor_ref);

      move_to(admin, StableSwapConfig {
        extend_ref,
        fee_to: FEE_ADMIN,
        current_admin: ADMIN,
        pending_admin: @0x0,
        fee_on: true,
        paused: false
      })
    };
  }

  #[test_only]
  friend razor_stable_swap::controller_tests;

  #[test_only]
  public fun initialize_for_testing(sender: &signer) {
    init_module(sender)
  }
}