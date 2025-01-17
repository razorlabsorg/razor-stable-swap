
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool`



-  [Struct `AddLiquidityEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_AddLiquidityEvent)
-  [Struct `RemoveLiquidityEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityEvent)
-  [Struct `RemoveLiquidityImbalanceEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityImbalanceEvent)
-  [Struct `RemoveLiquidityOne`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityOne)
-  [Struct `TokenExchangeEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_TokenExchangeEvent)
-  [Struct `RampAEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RampAEvent)
-  [Struct `StopRampAEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_StopRampAEvent)
-  [Struct `CommitNewFeeEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_CommitNewFeeEvent)
-  [Struct `ApplyNewFeeEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ApplyNewFeeEvent)
-  [Struct `LPTokenRefs`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_LPTokenRefs)
-  [Struct `RevertParameters`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RevertParameters)
-  [Struct `KillEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_KillEvent)
-  [Struct `UnkillEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_UnkillEvent)
-  [Resource `ThreePool`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool)
-  [Constants](#@Constants_0)
-  [Function `initialize`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_initialize)
-  [Function `fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_fee)
-  [Function `a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_a)
-  [Function `get_d`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_d)
-  [Function `get_virtual_price`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_virtual_price)
-  [Function `lp_token_supply`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_token_supply)
-  [Function `calc_token_amount`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_token_amount)
-  [Function `add_liquidity`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_add_liquidity)
-  [Function `get_dy`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy)
-  [Function `get_dy_underlying`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy_underlying)
-  [Function `exchange`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_exchange)
-  [Function `remove_liquidity`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity)
-  [Function `remove_liquidity_imbalance`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_imbalance)
-  [Function `calc_withdraw_one_coin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_withdraw_one_coin)
-  [Function `remove_liquidity_one_coin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_one_coin)
-  [Function `ramp_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ramp_a)
-  [Function `stop_rampget_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stop_rampget_a)
-  [Function `commit_new_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_commit_new_fee)
-  [Function `apply_new_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_apply_new_fee)
-  [Function `revert_new_parameters`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_revert_new_parameters)
-  [Function `withdraw_admin_fees`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_withdraw_admin_fees)
-  [Function `kill_me`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_kill_me)
-  [Function `unkill_me`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unkill_me)
-  [Function `pool_coins`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_coins)
-  [Function `pool_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_fee)
-  [Function `pool_admin_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_fee)
-  [Function `pool_initial_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a)
-  [Function `pool_future_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a)
-  [Function `pool_initial_a_time`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a_time)
-  [Function `pool_future_a_time`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a_time)
-  [Function `pool_kill_deadline`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_kill_deadline)
-  [Function `pool_admin_actions_deadline`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_actions_deadline)
-  [Function `pool_future_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_fee)
-  [Function `pool_future_admin_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_admin_fee)
-  [Function `pool_is_killed`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_is_killed)
-  [Function `pool_tokens`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_tokens)
-  [Function `pool_balances`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_balances)
-  [Function `pool_precision_muls`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_precision_muls)
-  [Function `pool_rates`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_rates)
-  [Function `get_pool_seeds`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_pool_seeds)
-  [Function `lp_balance_of`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_balance_of)
-  [Function `unpack_pool`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unpack_pool)
-  [Function `stable_swap_pool`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool)
-  [Function `stable_swap_pool_address_safe`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool_address_safe)
-  [Function `pool_address`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_address)


<pre><code><b>use</b> <a href="">0x1::bcs</a>;
<b>use</b> <a href="">0x1::comparator</a>;
<b>use</b> <a href="">0x1::dispatchable_fungible_asset</a>;
<b>use</b> <a href="">0x1::event</a>;
<b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::option</a>;
<b>use</b> <a href="">0x1::primary_fungible_store</a>;
<b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="">0x1::string</a>;
<b>use</b> <a href="">0x1::timestamp</a>;
<b>use</b> <a href="">0x1::vector</a>;
<b>use</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::controller</a>;
<b>use</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::swap_library</a>;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_AddLiquidityEvent"></a>

## Struct `AddLiquidityEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_AddLiquidityEvent">AddLiquidityEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityEvent"></a>

## Struct `RemoveLiquidityEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityEvent">RemoveLiquidityEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityImbalanceEvent"></a>

## Struct `RemoveLiquidityImbalanceEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityImbalanceEvent">RemoveLiquidityImbalanceEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityOne"></a>

## Struct `RemoveLiquidityOne`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RemoveLiquidityOne">RemoveLiquidityOne</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_TokenExchangeEvent"></a>

## Struct `TokenExchangeEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_TokenExchangeEvent">TokenExchangeEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RampAEvent"></a>

## Struct `RampAEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RampAEvent">RampAEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_StopRampAEvent"></a>

## Struct `StopRampAEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_StopRampAEvent">StopRampAEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_CommitNewFeeEvent"></a>

## Struct `CommitNewFeeEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_CommitNewFeeEvent">CommitNewFeeEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ApplyNewFeeEvent"></a>

## Struct `ApplyNewFeeEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ApplyNewFeeEvent">ApplyNewFeeEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_LPTokenRefs"></a>

## Struct `LPTokenRefs`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_LPTokenRefs">LPTokenRefs</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RevertParameters"></a>

## Struct `RevertParameters`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_RevertParameters">RevertParameters</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_KillEvent"></a>

## Struct `KillEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_KillEvent">KillEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_UnkillEvent"></a>

## Struct `UnkillEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_UnkillEvent">UnkillEvent</a> <b>has</b> drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool"></a>

## Resource `ThreePool`



<pre><code>#[resource_group_member(#[group = <a href="_ObjectGroup">0x1::object::ObjectGroup</a>])]
<b>struct</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">ThreePool</a> <b>has</b> key
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_FEE"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_FEE">MAX_FEE</a>: u256 = 5000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ADMIN_ACTIONS_DELAY"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ADMIN_ACTIONS_DELAY">ADMIN_ACTIONS_DELAY</a>: u64 = 259200;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_DEADLINE_IS_ZERO"></a>

Admin deadline is zero when it shouldn't be


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_DEADLINE_IS_ZERO">ERROR_ADMIN_DEADLINE_IS_ZERO</a>: u64 = 27;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_DEADLINE_NOT_ZERO"></a>

Admin deadline is not zero when it should be


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_DEADLINE_NOT_ZERO">ERROR_ADMIN_DEADLINE_NOT_ZERO</a>: u64 = 26;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_FEE_TOO_HIGH"></a>

Admin fee is set too high


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ADMIN_FEE_TOO_HIGH">ERROR_ADMIN_FEE_TOO_HIGH</a>: u64 = 8;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_COIN_DECIMAL_TOO_HIGH"></a>

Coin decimal precision is too high


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_COIN_DECIMAL_TOO_HIGH">ERROR_COIN_DECIMAL_TOO_HIGH</a>: u64 = 9;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_D1_MUST_BE_GREATER_THAN_D0"></a>

New D value must be greater than the old D value


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_D1_MUST_BE_GREATER_THAN_D0">ERROR_D1_MUST_BE_GREATER_THAN_D0</a>: u64 = 11;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_EXCEED_MAX_BURN_AMOUNT"></a>

Exceeds maximum burn amount


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_EXCEED_MAX_BURN_AMOUNT">ERROR_EXCEED_MAX_BURN_AMOUNT</a>: u64 = 21;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_EXCESS_BALANCE"></a>

Balance exceeds the allowed limit


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_EXCESS_BALANCE">ERROR_EXCESS_BALANCE</a>: u64 = 33;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEE_CHANGE_TOO_EARLY"></a>

Fee change attempted too early


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEE_CHANGE_TOO_EARLY">ERROR_FEE_CHANGE_TOO_EARLY</a>: u64 = 28;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEE_TOO_HIGH"></a>

Fee is set too high


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEE_TOO_HIGH">ERROR_FEE_TOO_HIGH</a>: u64 = 7;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEWER_COINS_IN_EXCHANGE"></a>

Fewer coins received in exchange than expected


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_FEWER_COINS_IN_EXCHANGE">ERROR_FEWER_COINS_IN_EXCHANGE</a>: u64 = 34;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS"></a>

Initial deposit requires all coins to be added


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS">ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS</a>: u64 = 12;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_COINS_REMOVED"></a>

Insufficient coins removed from the pool


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_COINS_REMOVED">ERROR_INSUFFICIENT_COINS_REMOVED</a>: u64 = 22;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_MINT_AMOUNT"></a>

Insufficient amount minted


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_MINT_AMOUNT">ERROR_INSUFFICIENT_MINT_AMOUNT</a>: u64 = 13;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_OUTPUT_AMOUNT"></a>

Insufficient output amount for the operation


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_OUTPUT_AMOUNT">ERROR_INSUFFICIENT_OUTPUT_AMOUNT</a>: u64 = 16;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT"></a>

Insufficient withdrawal amount


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT">ERROR_INSUFFICIENT_WITHDRAWAL_AMOUNT</a>: u64 = 17;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_A"></a>

Invalid amplification coefficient (A)


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_A">ERROR_INVALID_A</a>: u64 = 6;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_AMOUNTS"></a>

Invalid amounts provided for the operation


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_AMOUNTS">ERROR_INVALID_AMOUNTS</a>: u64 = 10;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_A_VALUE"></a>

Invalid amplification coefficient (A) value


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_A_VALUE">ERROR_INVALID_A_VALUE</a>: u64 = 25;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN"></a>

Invalid coin type for the operation


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN">ERROR_INVALID_COIN</a>: u64 = 3;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN_COUNT"></a>

Invalid number of coins for the operation


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN_COUNT">ERROR_INVALID_COIN_COUNT</a>: u64 = 5;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN_INDEX"></a>

Invalid coin index provided


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_COIN_INDEX">ERROR_INVALID_COIN_INDEX</a>: u64 = 14;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_D"></a>

Invalid D value calculated


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_INVALID_D">ERROR_INVALID_D</a>: u64 = 20;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_KILL_DEADLINE_PASSED"></a>

Kill deadline has already passed


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_KILL_DEADLINE_PASSED">ERROR_KILL_DEADLINE_PASSED</a>: u64 = 30;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_NO_ADMIN_FEES"></a>

No admin fees available


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_NO_ADMIN_FEES">ERROR_NO_ADMIN_FEES</a>: u64 = 29;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_ALREADY_INITIALIZED"></a>

Pool has already been initialized


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_ALREADY_INITIALIZED">ERROR_POOL_ALREADY_INITIALIZED</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_ALREADY_KILLED"></a>

Pool is already in a killed state


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_ALREADY_KILLED">ERROR_POOL_ALREADY_KILLED</a>: u64 = 31;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_IS_KILLED"></a>

Pool is in a killed state


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_IS_KILLED">ERROR_POOL_IS_KILLED</a>: u64 = 4;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_NOT_KILLED"></a>

Pool is not in a killed state


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_POOL_NOT_KILLED">ERROR_POOL_NOT_KILLED</a>: u64 = 32;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_RAMP_A_IN_PROGRESS"></a>

Amplification coefficient (A) ramping is already in progress


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_RAMP_A_IN_PROGRESS">ERROR_RAMP_A_IN_PROGRESS</a>: u64 = 23;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_RAMP_TIME_TOO_SHORT"></a>

Ramp time is too short


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_RAMP_TIME_TOO_SHORT">ERROR_RAMP_TIME_TOO_SHORT</a>: u64 = 24;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_UNAUTHORIZED"></a>

Caller is not authorized to make this call


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_UNAUTHORIZED">ERROR_UNAUTHORIZED</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ZERO_AMOUNT"></a>

Amount provided is zero


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ZERO_AMOUNT">ERROR_ZERO_AMOUNT</a>: u64 = 18;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ZERO_TOTAL_SUPPLY"></a>

Total supply is zero


<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ERROR_ZERO_TOTAL_SUPPLY">ERROR_ZERO_TOTAL_SUPPLY</a>: u64 = 19;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_FEE_DENOMINATOR"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_FEE_DENOMINATOR">FEE_DENOMINATOR</a>: u256 = 10000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_KILL_DEADLINE_DT"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_KILL_DEADLINE_DT">KILL_DEADLINE_DT</a>: u64 = 5184000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_LP_TOKEN_DECIMALS"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_LP_TOKEN_DECIMALS">LP_TOKEN_DECIMALS</a>: u8 = 8;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_A"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_A">MAX_A</a>: u256 = 1000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_ADMIN_FEE"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_ADMIN_FEE">MAX_ADMIN_FEE</a>: u256 = 10000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_A_CHANGE"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_A_CHANGE">MAX_A_CHANGE</a>: u256 = 10;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MIN_RAMP_TIME"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MIN_RAMP_TIME">MIN_RAMP_TIME</a>: u64 = 86400;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_N_COINS"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_N_COINS">N_COINS</a>: u64 = 3;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_PRECISION"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_PRECISION">PRECISION</a>: u256 = 1000000000000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_COIN_DECIMAL"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MAX_COIN_DECIMAL">MAX_COIN_DECIMAL</a>: u8 = 8;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MINIMUM_LIQUIDITY"></a>



<pre><code><b>const</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_MINIMUM_LIQUIDITY">MINIMUM_LIQUIDITY</a>: u64 = 1000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_initialize"></a>

## Function `initialize`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_initialize">initialize</a>(coins: <a href="">vector</a>&lt;<a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;&gt;, a: u256, fee: u256, admin_fee: u256): <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_fee"></a>

## Function `fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_fee">fee</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_a"></a>

## Function `a`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_a">a</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_d"></a>

## Function `get_d`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_d">get_d</a>(xp: &<a href="">vector</a>&lt;u256&gt;, amp: u256): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_virtual_price"></a>

## Function `get_virtual_price`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_virtual_price">get_virtual_price</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_token_supply"></a>

## Function `lp_token_supply`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_token_supply">lp_token_supply</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u128
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_token_amount"></a>

## Function `calc_token_amount`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_token_amount">calc_token_amount</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, amounts: <a href="">vector</a>&lt;u256&gt;, is_deposit: bool): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_add_liquidity"></a>

## Function `add_liquidity`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_add_liquidity">add_liquidity</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, amounts: <a href="">vector</a>&lt;<a href="_FungibleAsset">fungible_asset::FungibleAsset</a>&gt;, min_mint_amount: u256, sender: &<a href="">signer</a>): <a href="_FungibleAsset">fungible_asset::FungibleAsset</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy"></a>

## Function `get_dy`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy">get_dy</a>(i: u64, j: u64, dx: u256, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy_underlying"></a>

## Function `get_dy_underlying`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_dy_underlying">get_dy_underlying</a>(i: u64, j: u64, dx: u256, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_exchange"></a>

## Function `exchange`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_exchange">exchange</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, i: u64, j: u64, dx: <a href="_FungibleAsset">fungible_asset::FungibleAsset</a>, min_dy: u256, sender: &<a href="">signer</a>): <a href="_FungibleAsset">fungible_asset::FungibleAsset</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity"></a>

## Function `remove_liquidity`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity">remove_liquidity</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, lp_amount: <a href="_FungibleAsset">fungible_asset::FungibleAsset</a>, min_amounts: <a href="">vector</a>&lt;u256&gt;, recipient: <b>address</b>): <a href="">vector</a>&lt;<a href="_FungibleAsset">fungible_asset::FungibleAsset</a>&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_imbalance"></a>

## Function `remove_liquidity_imbalance`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_imbalance">remove_liquidity_imbalance</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, amounts: <a href="">vector</a>&lt;u256&gt;, max_burn_amount: u256, recipient: <b>address</b>): <a href="">vector</a>&lt;<a href="_FungibleAsset">fungible_asset::FungibleAsset</a>&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_withdraw_one_coin"></a>

## Function `calc_withdraw_one_coin`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_calc_withdraw_one_coin">calc_withdraw_one_coin</a>(pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, token_amount: u256, i: u64): (u256, u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_one_coin"></a>

## Function `remove_liquidity_one_coin`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_remove_liquidity_one_coin">remove_liquidity_one_coin</a>(token_amount: u256, i: u64, min_amount: u256, provider: <b>address</b>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): <a href="_FungibleAsset">fungible_asset::FungibleAsset</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ramp_a"></a>

## Function `ramp_a`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ramp_a">ramp_a</a>(admin: &<a href="">signer</a>, future_a: u256, future_time: u256, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stop_rampget_a"></a>

## Function `stop_rampget_a`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stop_rampget_a">stop_rampget_a</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_commit_new_fee"></a>

## Function `commit_new_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_commit_new_fee">commit_new_fee</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;, new_fee: u256, new_admin_fee: u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_apply_new_fee"></a>

## Function `apply_new_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_apply_new_fee">apply_new_fee</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_revert_new_parameters"></a>

## Function `revert_new_parameters`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_revert_new_parameters">revert_new_parameters</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_withdraw_admin_fees"></a>

## Function `withdraw_admin_fees`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_withdraw_admin_fees">withdraw_admin_fees</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): <a href="">vector</a>&lt;<a href="_FungibleAsset">fungible_asset::FungibleAsset</a>&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_kill_me"></a>

## Function `kill_me`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_kill_me">kill_me</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unkill_me"></a>

## Function `unkill_me`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unkill_me">unkill_me</a>(admin: &<a href="">signer</a>, pool: &<a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_coins"></a>

## Function `pool_coins`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_coins">pool_coins</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): <a href="">vector</a>&lt;<a href="_Object">object::Object</a>&lt;<a href="_FungibleStore">fungible_asset::FungibleStore</a>&gt;&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_fee"></a>

## Function `pool_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_fee">pool_fee</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_fee"></a>

## Function `pool_admin_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_fee">pool_admin_fee</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a"></a>

## Function `pool_initial_a`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a">pool_initial_a</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a"></a>

## Function `pool_future_a`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a">pool_future_a</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a_time"></a>

## Function `pool_initial_a_time`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_initial_a_time">pool_initial_a_time</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u64
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a_time"></a>

## Function `pool_future_a_time`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_a_time">pool_future_a_time</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u64
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_kill_deadline"></a>

## Function `pool_kill_deadline`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_kill_deadline">pool_kill_deadline</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u64
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_actions_deadline"></a>

## Function `pool_admin_actions_deadline`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_admin_actions_deadline">pool_admin_actions_deadline</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u64
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_fee"></a>

## Function `pool_future_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_fee">pool_future_fee</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_admin_fee"></a>

## Function `pool_future_admin_fee`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_future_admin_fee">pool_future_admin_fee</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_is_killed"></a>

## Function `pool_is_killed`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_is_killed">pool_is_killed</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): bool
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_tokens"></a>

## Function `pool_tokens`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_tokens">pool_tokens</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): (<a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_balances"></a>

## Function `pool_balances`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_balances">pool_balances</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_precision_muls"></a>

## Function `pool_precision_muls`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_precision_muls">pool_precision_muls</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_rates"></a>

## Function `pool_rates`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_rates">pool_rates</a>&lt;T: key&gt;(pool: &<a href="_Object">object::Object</a>&lt;T&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_pool_seeds"></a>

## Function `get_pool_seeds`



<pre><code><b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_get_pool_seeds">get_pool_seeds</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="">vector</a>&lt;u8&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_balance_of"></a>

## Function `lp_balance_of`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_lp_balance_of">lp_balance_of</a>&lt;T: key&gt;(<a href="">account</a>: <b>address</b>, pool: <a href="_Object">object::Object</a>&lt;T&gt;): u64
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unpack_pool"></a>

## Function `unpack_pool`



<pre><code>#[view]
<b>public</b>(<b>friend</b>) <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_unpack_pool">unpack_pool</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;): (<a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool"></a>

## Function `stable_swap_pool`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool">stable_swap_pool</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="_Object">object::Object</a>&lt;<a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_ThreePool">three_pool::ThreePool</a>&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool_address_safe"></a>

## Function `stable_swap_pool_address_safe`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_stable_swap_pool_address_safe">stable_swap_pool_address_safe</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): (bool, <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_address"></a>

## Function `pool_address`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_pool_address">pool_address</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <b>address</b>
</code></pre>
