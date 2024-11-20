module razor_stable_swap::stable_swap_errors {
  use std::error;

  friend razor_stable_swap::stable_swap_library;

  friend razor_stable_swap::controller;
  friend razor_stable_swap::two_pool;
  friend razor_stable_swap::two_pool_deployer;
  friend razor_stable_swap::three_pool;
  friend razor_stable_swap::three_pool_deployer;
  friend razor_stable_swap::stable_swap_factory;
  friend razor_stable_swap::stable_swap_router;

  /// Pool Reserves is Zero
  const ERROR_ZERO_POOL_RESERVES: u64 = 0;
  /// Insufficient Liquidity
  const ERROR_INSUFFICIENT_LIQUIDITY: u64 = 1;
  /// Identical Addresses
  const ERROR_IDENTICAL_ADDRESSES: u64 = 2;
  /// Invalid Swap Path
  const ERROR_INVALID_PATH: u64 = 3;
  /// Insufficient Amount
  const ERROR_INSUFFICIENT_AMOUNT: u64 = 4;
  /// Insufficient Input Amount
  const ERROR_INSUFFICIENT_INPUT_AMOUNT: u64 = 5;
  /// Insufficient Output Amount
  const ERROR_INSUFFICIENT_OUTPUT_AMOUNT: u64 = 6;
  /// Insufficient B Amount
  const ERROR_INSUFFICIENT_B_AMOUNT: u64 = 7;
  /// Insufficient A Amount
  const ERROR_INSUFFICIENT_A_AMOUNT: u64 = 8;
  /// Internal Error
  const ERROR_INTERNAL_ERROR: u64 = 9;
  /// When divide by zero attempted.
  const ERROR_DIVIDE_BY_ZERO: u64 = 10;
  /// Caller is not authorized to make this call
  const ERROR_UNAUTHORIZED: u64 = 11;
  /// No operations are allowed when contract is paused
  const ERROR_PAUSED: u64 = 12;
  /// Contract is needs to be paused first
  const ERROR_UNPAUSED: u64 = 13;
  /// The account is not owner
  const ERROR_NOT_OWNER: u64 = 14;
  /// The account is denylisted
  const ERROR_DENYLISTED: u64 = 15;
  /// Operation is not allowed
  const ERROR_FORBIDDEN: u64 = 16;
  /// The pool already exists
  const ERROR_POOL_EXISTS: u64 = 17;
  /// Index out of bounds
  const ERROR_INDEX_OUT_OF_BOUNDS: u64 = 18;
  /// Only admin can call this
  const ERROR_ONLY_ADMIN: u64 = 19;
  /// When contract is not reentrant
  const ERROR_LOCKED: u64 = 20;
  /// When zero amount for pool
  const ERROR_ZERO_AMOUNT: u64 = 21;
  /// When not enough liquidity minted
  const ERROR_INSUFFICIENT_LIQUIDITY_MINT: u64 = 22;
  /// When not enough liquidity burned
  const ERROR_INSUFFICIENT_LIQUIDITY_BURN: u64 = 23;
  /// When contract K error
  const ERROR_K_ERROR: u64 = 24;
  /// Transaction expired
  const ERROR_EXPIRED: u64 = 25;
  /// Invalid pid
  const ERROR_INVALID_PID: u64 = 26;
  /// Pool not exists
  const ERROR_POOL_NOT_EXIST: u64 = 27;
  /// Reward Pool already exists
  const ERROR_ALREADY_ADDED: u64 = 4;
  /// Invalid input lengths
  const ERR_INVALID_VECTOR_LENGTH: u64 = 24;
  /// Invalid token address for requested pool
  const ERR_INVALID_TOKEN_ADDRESS: u64 = 25;

  /// Excessive input amount
  const ERR_EXCESSIVE_INPUT_AMOUNT: u64 = 26;

  public(friend) fun zero_pool_reserves(): u64 {
    error::out_of_range(ERROR_ZERO_POOL_RESERVES)
  }

  public(friend) fun insufficient_liquidity(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_LIQUIDITY)
  }

  public(friend) fun identical_addresses(): u64 {
    error::invalid_argument(ERROR_IDENTICAL_ADDRESSES)
  }

  public(friend) fun invalid_path(): u64 {
    error::invalid_argument(ERROR_INVALID_PATH)
  }

  public(friend) fun insufficient_amount(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_AMOUNT)
  }

  public(friend) fun insufficient_input_amount(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_INPUT_AMOUNT)
  }

  public(friend) fun insufficient_output_amount(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_OUTPUT_AMOUNT)
  }

  public(friend) fun insufficient_b_amount(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_B_AMOUNT)
  }

  public(friend) fun insufficient_a_amount(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_A_AMOUNT)
  }

  public(friend) fun internal_error(): u64 {
    error::internal(ERROR_INTERNAL_ERROR)
  }

  public(friend) fun divide_by_zero(): u64 {
    error::invalid_argument(ERROR_DIVIDE_BY_ZERO)
  }

  public(friend) fun unauthorized(): u64 {
    error::permission_denied(ERROR_UNAUTHORIZED)
  }

  public(friend) fun paused(): u64 {
    error::invalid_state(ERROR_PAUSED)
  }

  public(friend) fun unpaused(): u64 {
    error::invalid_state(ERROR_UNPAUSED)
  }

  public(friend) fun not_owner(): u64 {
    error::permission_denied(ERROR_NOT_OWNER)
  }

  public(friend) fun denylisted(): u64 {
    error::permission_denied(ERROR_DENYLISTED)
  }

  public(friend) fun forbidden(): u64 {
    error::permission_denied(ERROR_FORBIDDEN)
  }

  public(friend) fun pool_exists(): u64 {
    error::already_exists(ERROR_POOL_EXISTS)
  }

  public(friend) fun index_out_of_bounds(): u64 {
    error::out_of_range(ERROR_INDEX_OUT_OF_BOUNDS)
  }

  public(friend) fun only_admin(): u64 {
    error::permission_denied(ERROR_ONLY_ADMIN)
  }

  public(friend) fun locked(): u64 {
    error::invalid_state(ERROR_LOCKED)
  }

  public(friend) fun zero_amount(): u64 {
    error::out_of_range(ERROR_ZERO_AMOUNT)
  }

  public(friend) fun insufficient_liquidity_mint(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_LIQUIDITY_MINT)
  }

  public(friend) fun insufficient_liquidity_burn(): u64 {
    error::out_of_range(ERROR_INSUFFICIENT_LIQUIDITY_BURN)
  }

  public(friend) fun k_error(): u64 {
    error::internal(ERROR_K_ERROR)
  }

  public(friend) fun expired(): u64 {
    error::internal(ERROR_EXPIRED)
  }

  public(friend) fun invalid_pid(): u64 {
    error::invalid_argument(ERROR_INVALID_PID)
  }

  public(friend) fun pool_not_exist(): u64 {
    error::invalid_argument(ERROR_POOL_NOT_EXIST)
  }

  public(friend) fun already_added(): u64 {
    error::already_exists(ERROR_ALREADY_ADDED)
  }

  public(friend) fun invalid_vector_length(): u64 {
    error::invalid_argument(ERR_INVALID_VECTOR_LENGTH)
  }

  public(friend) fun invalid_token_address(): u64 {
    error::invalid_argument(ERR_INVALID_TOKEN_ADDRESS)
  }

  public(friend) fun excessive_input_amount(): u64 {
    error::invalid_argument(ERR_EXCESSIVE_INPUT_AMOUNT)
  }
}