// This module is responsible for housekeeping
module razor_stable_swap::controller {
  use std::signer;
  use std::string::String;

  use aptos_std::smart_table::{Self, SmartTable};
  use aptos_framework::account::{Self, SignerCapability};
  use aptos_framework::resource_account;

  friend razor_stable_swap::three_pool;
  friend razor_stable_swap::two_pool;
  friend razor_stable_swap::stable_swap_factory;

  const FEE_ADMIN: address = @fee_admin;
  const ADMIN: address = @admin;

  const ERROR_PAUSED: u64 = 0;
  const ERROR_UNPAUSED: u64 = 1;
  const ERROR_FORBIDDEN: u64 = 2;

  struct ControllerConfig has key {
    addresses: SmartTable<String, address>,
    signer_cap: SignerCapability,
  }

  struct StableSwapConfig has key {
    fee_to: address,
    current_admin: address,
    pending_admin: address,
    fee_on: bool,
    paused: bool,
  }

  fun init_module(admin: &signer) {
    let signer_cap = resource_account::retrieve_resource_account_cap(admin, @admin);
    move_to(admin, ControllerConfig {
      addresses: smart_table::new<String, address>(),
      signer_cap: signer_cap
    });

    move_to(admin, StableSwapConfig {
      fee_to: FEE_ADMIN,
      current_admin: ADMIN,
      pending_admin: @0x0,
      fee_on: true,
      paused: false
    })
  }

  public(friend) fun get_signer(): signer acquires ControllerConfig {
    let signer_cap = &borrow_global<ControllerConfig>(@razor_stable_swap).signer_cap;
    account::create_signer_with_capability(signer_cap)
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

  public fun assert_paused() acquires StableSwapConfig {
    assert!(stable_swap_config().paused == true, ERROR_PAUSED);
  }

  public fun assert_unpaused() acquires StableSwapConfig {
    assert!(stable_swap_config().paused == false, ERROR_UNPAUSED);
  }

  public fun assert_admin(account: &signer) acquires StableSwapConfig {
    assert!(stable_swap_config().current_admin == signer::address_of(account), ERROR_FORBIDDEN);
  }

  public(friend) fun pause(account: &signer) acquires StableSwapConfig {
    assert_unpaused();
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.paused = true;
  }

  public(friend) fun unpause(account: &signer) acquires StableSwapConfig {
    assert_paused();
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.paused = false;
  }

  public(friend) fun set_admin_address(
    account: &signer,
    admin_address: address
  ) acquires StableSwapConfig {
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.current_admin, ERROR_FORBIDDEN);
    swap_config.pending_admin = admin_address;
  }

  public(friend) fun claim_admin(
    account: &signer
  ) acquires StableSwapConfig {
    let swap_config = borrow_global_mut<StableSwapConfig>(@razor_stable_swap);
    assert!(signer::address_of(account) == swap_config.pending_admin, ERROR_FORBIDDEN);
    swap_config.current_admin = swap_config.pending_admin;
    swap_config.pending_admin = @0x0;
  }

  public(friend) fun add_address(name: String, object: address) acquires ControllerConfig {
    let addresses = &mut borrow_global_mut<ControllerConfig>(@razor_stable_swap).addresses;
    smart_table::add(addresses, name, object);
  }

  public fun address_exists(name: String): bool acquires ControllerConfig {
    smart_table::contains(&safe_permission_config().addresses, name)
  }

  public fun get_address(name: String): address acquires ControllerConfig {
    let addresses = &borrow_global<ControllerConfig>(@razor_stable_swap).addresses;
    *smart_table::borrow(addresses, name)
  }

  inline fun safe_permission_config(): &ControllerConfig acquires ControllerConfig {
    borrow_global<ControllerConfig>(@razor_stable_swap)
  }

  inline fun stable_swap_config(): &StableSwapConfig acquires StableSwapConfig {
    borrow_global<StableSwapConfig>(@razor_stable_swap)
  }

  #[test_only]
  public fun initialize_for_test(admin: &signer) {
    let admin_address = signer::address_of(admin);
    if (!exists<ControllerConfig>(@razor_stable_swap)) {
      aptos_framework::timestamp::set_time_has_started_for_testing(&account::create_signer_for_test(@0x1));

      account::create_account_for_test(admin_address);
      move_to(admin, ControllerConfig{
        addresses: smart_table::new<String, address>(),
        signer_cap: account::create_test_signer_cap(admin_address)
      });

      move_to(admin, StableSwapConfig {
        fee_to: FEE_ADMIN,
        current_admin: ADMIN,
        pending_admin: @0x0,
        fee_on: true,
        paused: false
      })
    };
  }

  // #[test_only]
  // friend razor_stable_swap::controller_tests;

  #[test_only]
  public fun initialize(sender: &signer) {
    init_module(sender)
  }
}