module razor_stable_swap::swap_errors {
    use std::error;

    friend razor_stable_swap::three_pool;
    friend razor_stable_swap::two_pool;
    friend razor_stable_swap::three_pool_info;
    friend razor_stable_swap::two_pool_info;

    /// Pool has already been initialized
    const ERROR_POOL_ALREADY_INITIALIZED: u64 = 1;
    /// Caller is not authorized to make this call
    const ERROR_UNAUTHORIZED: u64 = 2;
    /// Invalid coin type for the operation
    const ERROR_INVALID_COIN: u64 = 3;
    /// Pool is in a killed state
    const ERROR_POOL_IS_KILLED: u64 = 4;
    /// Invalid number of coins for the operation
    const ERROR_INVALID_COIN_COUNT: u64 = 5;
    /// Invalid amplification coefficient (A)
    const ERROR_INVALID_A: u64 = 6;
    /// Fee is set too high
    const ERROR_FEE_TOO_HIGH: u64 = 7;
    /// Admin fee is set too high
    const ERROR_ADMIN_FEE_TOO_HIGH: u64 = 8;
    /// Coin decimal precision is too high
    const ERROR_COIN_DECIMAL_TOO_HIGH: u64 = 9;
    /// Invalid amounts provided for the operation
    const ERROR_INVALID_AMOUNTS: u64 = 10;
    /// New D value must be greater than the old D value
    const ERROR_D1_MUST_BE_GREATER_THAN_D0: u64 = 11;
    /// Initial deposit requires all coins to be added
    const ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS: u64 = 12;
    /// Insufficient amount minted
    const ERROR_INSUFFICIENT_MINT_AMOUNT: u64 = 13;
    /// Invalid coin index provided
    const ERROR_INVALID_COIN_INDEX: u64 = 14;
    /// Insufficient output amount for the operation
    const ERROR_INSUFFICIENT_OUTPUT_AMOUNT: u64 = 16;
    /// Insufficient withdrawal amount
    const ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT: u64 = 17;
    /// Amount provided is zero
    const ERROR_ZERO_AMOUNT: u64 = 18;
    /// Total supply is zero
    const ERROR_ZERO_TOTAL_SUPPLY: u64 = 19;
    /// Invalid D value calculated
    const ERROR_INVALID_D: u64 = 20;
    /// Exceeds maximum burn amount
    const ERROR_EXCEED_MAX_BURN_AMOUNT: u64 = 21;
    /// Insufficient coins removed from the pool
    const ERROR_INSUFFICIENT_COINS_REMOVED: u64 = 22;
    /// Amplification coefficient (A) ramping is already in progress
    const ERROR_RAMP_A_IN_PROGRESS: u64 = 23;
    /// Ramp time is too short
    const ERROR_RAMP_TIME_TOO_SHORT: u64 = 24;
    /// Invalid amplification coefficient (A) value
    const ERROR_INVALID_A_VALUE: u64 = 25;
    /// Admin deadline is not zero when it should be
    const ERROR_ADMIN_DEADLINE_NOT_ZERO: u64 = 26;
    /// Admin deadline is zero when it shouldn't be
    const ERROR_ADMIN_DEADLINE_IS_ZERO: u64 = 27;
    /// Fee change attempted too early
    const ERROR_FEE_CHANGE_TOO_EARLY: u64 = 28;
    /// No admin fees available
    const ERROR_NO_ADMIN_FEES: u64 = 29;
    /// Kill deadline has already passed
    const ERROR_KILL_DEADLINE_PASSED: u64 = 30;
    /// Pool is already in a killed state
    const ERROR_POOL_ALREADY_KILLED: u64 = 31;
    /// Pool is not in a killed state
    const ERROR_POOL_NOT_KILLED: u64 = 32;
    /// Balance exceeds the allowed limit
    const ERROR_EXCESS_BALANCE: u64 = 33;
    /// Fewer coins received in exchange than expected
    const ERROR_FEWER_COINS_IN_EXCHANGE: u64 = 34;

    public(friend) fun pool_already_initialized(): u64 { error::already_exists(ERROR_POOL_ALREADY_INITIALIZED) }
    public(friend) fun unauthorized(): u64 { error::permission_denied(ERROR_UNAUTHORIZED) }
    public(friend) fun invalid_coin(): u64 { error::invalid_argument(ERROR_INVALID_COIN) }
    public(friend) fun pool_is_killed(): u64 { error::invalid_state(ERROR_POOL_IS_KILLED) }
    public(friend) fun invalid_coin_count(): u64 { error::invalid_argument(ERROR_INVALID_COIN_COUNT) }
    public(friend) fun invalid_a(): u64 { error::invalid_argument(ERROR_INVALID_A) }
    public(friend) fun fee_too_high(): u64 { error::invalid_argument(ERROR_FEE_TOO_HIGH) }
    public(friend) fun admin_fee_too_high(): u64 { error::invalid_argument(ERROR_ADMIN_FEE_TOO_HIGH) }
    public(friend) fun coin_decimal_too_high(): u64 { error::invalid_argument(ERROR_COIN_DECIMAL_TOO_HIGH) }
    public(friend) fun invalid_amounts(): u64 { error::invalid_argument(ERROR_INVALID_AMOUNTS) }
    public(friend) fun d1_must_be_greater_than_d0(): u64 { error::invalid_state(ERROR_D1_MUST_BE_GREATER_THAN_D0) }
    public(friend) fun initial_deposit_requires_all_coins(): u64 { error::invalid_argument(ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS) }
    public(friend) fun insufficient_mint_amount(): u64 { error::invalid_argument(ERROR_INSUFFICIENT_MINT_AMOUNT) }
    public(friend) fun invalid_coin_index(): u64 { error::invalid_argument(ERROR_INVALID_COIN_INDEX) }
    public(friend) fun insufficient_output_amount(): u64 { error::invalid_argument(ERROR_INSUFFICIENT_OUTPUT_AMOUNT) }
    public(friend) fun insufficient_withdrawal_amount(): u64 { error::invalid_argument(ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT) }
    public(friend) fun zero_amount(): u64 { error::invalid_argument(ERROR_ZERO_AMOUNT) }
    public(friend) fun zero_total_supply(): u64 { error::invalid_state(ERROR_ZERO_TOTAL_SUPPLY) }
    public(friend) fun invalid_d(): u64 { error::invalid_argument(ERROR_INVALID_D) }
    public(friend) fun exceed_max_burn_amount(): u64 { error::invalid_argument(ERROR_EXCEED_MAX_BURN_AMOUNT) }
    public(friend) fun insufficient_coins_removed(): u64 { error::invalid_argument(ERROR_INSUFFICIENT_COINS_REMOVED) }
    public(friend) fun ramp_a_in_progress(): u64 { error::invalid_state(ERROR_RAMP_A_IN_PROGRESS) }
    public(friend) fun ramp_time_too_short(): u64 { error::invalid_argument(ERROR_RAMP_TIME_TOO_SHORT) }
    public(friend) fun invalid_a_value(): u64 { error::invalid_argument(ERROR_INVALID_A_VALUE) }
    public(friend) fun admin_deadline_not_zero(): u64 { error::invalid_state(ERROR_ADMIN_DEADLINE_NOT_ZERO) }
    public(friend) fun admin_deadline_is_zero(): u64 { error::invalid_state(ERROR_ADMIN_DEADLINE_IS_ZERO) }
    public(friend) fun fee_change_too_early(): u64 { error::invalid_state(ERROR_FEE_CHANGE_TOO_EARLY) }
    public(friend) fun no_admin_fees(): u64 { error::invalid_state(ERROR_NO_ADMIN_FEES) }
    public(friend) fun kill_deadline_passed(): u64 { error::invalid_state(ERROR_KILL_DEADLINE_PASSED) }
    public(friend) fun pool_already_killed(): u64 { error::invalid_state(ERROR_POOL_ALREADY_KILLED) }
    public(friend) fun pool_not_killed(): u64 { error::invalid_state(ERROR_POOL_NOT_KILLED) }
    public(friend) fun excess_balance(): u64 { error::invalid_argument(ERROR_EXCESS_BALANCE) }
    public(friend) fun fewer_coins_in_exchange(): u64 { error::invalid_argument(ERROR_FEWER_COINS_IN_EXCHANGE) }
}