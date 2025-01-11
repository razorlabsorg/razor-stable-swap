
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool_info`



-  [Constants](#@Constants_0)
-  [Function `fee_denominator`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee_denominator)
-  [Function `token`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_token)
-  [Function `lp_token_supply`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_lp_token_supply)
-  [Function `fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee)
-  [Function `a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_a)
-  [Function `balances`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances)
-  [Function `rates`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_rates)
-  [Function `balance_from_token_address`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balance_from_token_address)
-  [Function `balances_with_positions`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances_with_positions)
-  [Function `precision_mul`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_precision_mul)
-  [Function `calc_coins_amount`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_calc_coins_amount)
-  [Function `get_d_mem`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_d_mem)
-  [Function `get_add_liquidity_mint_amount`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_mint_amount)
-  [Function `get_add_liquidity_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_fee)
-  [Function `get_remove_liquidity_imbalance_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_imbalance_fee)
-  [Function `get_exchange_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_exchange_fee)
-  [Function `get_remove_liquidity_one_coin_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_one_coin_fee)
-  [Function `get_dx`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dx)
-  [Function `get_dy`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dy)


<pre><code><b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::option</a>;
<b>use</b> <a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_D1_MUST_BE_GREATER_THAN_D0"></a>

D1 must be greater than D0


<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_D1_MUST_BE_GREATER_THAN_D0">ERROR_D1_MUST_BE_GREATER_THAN_D0</a>: u64 = 4;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_EXCESS_BALANCE"></a>

Excess balance


<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_EXCESS_BALANCE">ERROR_EXCESS_BALANCE</a>: u64 = 3;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_FEWER_COINS_IN_EXCHANGE"></a>

Fewer coins in exchange


<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_FEWER_COINS_IN_EXCHANGE">ERROR_FEWER_COINS_IN_EXCHANGE</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS"></a>

Initial deposit requires all coins


<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS">ERROR_INITIAL_DEPOSIT_REQUIRES_ALL_COINS</a>: u64 = 5;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_INVALID_COIN_INDEX"></a>

Invalid coin index


<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_ERROR_INVALID_COIN_INDEX">ERROR_INVALID_COIN_INDEX</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_FEE_DENOMINATOR"></a>



<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_FEE_DENOMINATOR">FEE_DENOMINATOR</a>: u256 = 10000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_N_COINS"></a>



<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_N_COINS">N_COINS</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_PRECISION"></a>



<pre><code><b>const</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_PRECISION">PRECISION</a>: u256 = 1000000000000000000;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee_denominator"></a>

## Function `fee_denominator`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee_denominator">fee_denominator</a>(): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_token"></a>

## Function `token`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_token">token</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): <b>address</b>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_lp_token_supply"></a>

## Function `lp_token_supply`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_lp_token_supply">lp_token_supply</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): u128
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee"></a>

## Function `fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_fee">fee</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_a"></a>

## Function `a`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_a">a</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances"></a>

## Function `balances`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances">balances</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_rates"></a>

## Function `rates`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_rates">rates</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balance_from_token_address"></a>

## Function `balance_from_token_address`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balance_from_token_address">balance_from_token_address</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, token_address: <b>address</b>): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances_with_positions"></a>

## Function `balances_with_positions`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_balances_with_positions">balances_with_positions</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, positions: <a href="">vector</a>&lt;<b>address</b>&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_precision_mul"></a>

## Function `precision_mul`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_precision_mul">precision_mul</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_calc_coins_amount"></a>

## Function `calc_coins_amount`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_calc_coins_amount">calc_coins_amount</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, amount: u256): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_d_mem"></a>

## Function `get_d_mem`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_d_mem">get_d_mem</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, balances: <a href="">vector</a>&lt;u256&gt;, amp: u256): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_mint_amount"></a>

## Function `get_add_liquidity_mint_amount`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_mint_amount">get_add_liquidity_mint_amount</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, amounts: <a href="">vector</a>&lt;u256&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_fee"></a>

## Function `get_add_liquidity_fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_add_liquidity_fee">get_add_liquidity_fee</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, amounts: <a href="">vector</a>&lt;u256&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_imbalance_fee"></a>

## Function `get_remove_liquidity_imbalance_fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_imbalance_fee">get_remove_liquidity_imbalance_fee</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, amounts: <a href="">vector</a>&lt;u256&gt;): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_exchange_fee"></a>

## Function `get_exchange_fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_exchange_fee">get_exchange_fee</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, i: u64, j: u64, dx: u256): (u256, u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_one_coin_fee"></a>

## Function `get_remove_liquidity_one_coin_fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_remove_liquidity_one_coin_fee">get_remove_liquidity_one_coin_fee</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, token_amount: u256, i: u64): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dx"></a>

## Function `get_dx`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dx">get_dx</a>(pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;, i: u64, j: u64, dy: u256, max_dx: u256): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dy"></a>

## Function `get_dy`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info_get_dy">get_dy</a>(i: u64, j: u64, dx: u256, pool: <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;): u256
</code></pre>
