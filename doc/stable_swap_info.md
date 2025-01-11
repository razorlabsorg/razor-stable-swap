
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::stable_swap_info`



-  [Function `fee_denominator`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee_denominator)
-  [Function `lp_token_supply`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_lp_token_supply)
-  [Function `fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee)
-  [Function `get_dx`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dx)
-  [Function `get_dy`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dy)
-  [Function `calc_coins_amount`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_calc_coins_amount)
-  [Function `get_add_liquidity_mint_amount`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_add_liquidity_mint_amount)
-  [Function `get_exchange_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_exchange_fee)
-  [Function `balances`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_balances)
-  [Function `a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_a)


<pre><code><b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool</a>;
<b>use</b> <a href="three_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_info">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool_info</a>;
<b>use</b> <a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool</a>;
<b>use</b> <a href="two_pool_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_info">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool_info</a>;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee_denominator"></a>

## Function `fee_denominator`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee_denominator">fee_denominator</a>(swap_address: <b>address</b>): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_lp_token_supply"></a>

## Function `lp_token_supply`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_lp_token_supply">lp_token_supply</a>(lp_token_address: <b>address</b>): u128
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee"></a>

## Function `fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_fee">fee</a>(swap_address: <b>address</b>): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dx"></a>

## Function `get_dx`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dx">get_dx</a>(swap_address: <b>address</b>, i: u64, j: u64, dy: u256, max_dx: u256): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dy"></a>

## Function `get_dy`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_dy">get_dy</a>(swap_address: <b>address</b>, i: u64, j: u64, dx: u256): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_calc_coins_amount"></a>

## Function `calc_coins_amount`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_calc_coins_amount">calc_coins_amount</a>(swap_address: <b>address</b>, amount: u256): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_add_liquidity_mint_amount"></a>

## Function `get_add_liquidity_mint_amount`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_add_liquidity_mint_amount">get_add_liquidity_mint_amount</a>(swap_address: <b>address</b>, amounts: <a href="">vector</a>&lt;u256&gt;): u256
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_exchange_fee"></a>

## Function `get_exchange_fee`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_get_exchange_fee">get_exchange_fee</a>(swap_address: <b>address</b>, i: u64, j: u64, dx: u256): (u256, u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_balances"></a>

## Function `balances`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_balances">balances</a>(swap_address: <b>address</b>): <a href="">vector</a>&lt;u256&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_a"></a>

## Function `a`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info_a">a</a>(swap_address: <b>address</b>): u256
</code></pre>
