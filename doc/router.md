
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::router`



-  [Constants](#@Constants_0)
-  [Function `add_liquidity`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_add_liquidity)
-  [Function `remove_liquidity`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity)
-  [Function `remove_liquidity_imbalance`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_imbalance)
-  [Function `remove_liquidity_one_coin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_one_coin)
-  [Function `swap_exact_input`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_input)
-  [Function `swap_exact_output`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_output)
-  [Function `ramp_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ramp_a)
-  [Function `stop_ramp_a`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_stop_ramp_a)
-  [Function `commit_new_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_commit_new_fee)
-  [Function `apply_new_fee`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_apply_new_fee)
-  [Function `revert_new_parameters`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_revert_new_parameters)
-  [Function `withdraw_admin_fees`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_withdraw_admin_fees)
-  [Function `kill_me`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_kill_me)
-  [Function `unkill_me`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_unkill_me)


<pre><code><b>use</b> <a href="">0x1::dispatchable_fungible_asset</a>;
<b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::primary_fungible_store</a>;
<b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="router_helper.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::router_helper</a>;
<b>use</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::swap_library</a>;
<b>use</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool</a>;
<b>use</b> <a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ERROR_EXCESSIVE_INPUT_AMOUNT"></a>

Excessive input amount


<pre><code><b>const</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ERROR_EXCESSIVE_INPUT_AMOUNT">ERROR_EXCESSIVE_INPUT_AMOUNT</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ERROR_INVALID_VECTOR_LENGTH"></a>

Invalid input lengths


<pre><code><b>const</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ERROR_INVALID_VECTOR_LENGTH">ERROR_INVALID_VECTOR_LENGTH</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_THREE"></a>



<pre><code><b>const</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_THREE">THREE</a>: u64 = 3;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_TWO"></a>



<pre><code><b>const</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_TWO">TWO</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_add_liquidity"></a>

## Function `add_liquidity`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_add_liquidity">add_liquidity</a>(pool: <b>address</b>, amounts: <a href="">vector</a>&lt;u64&gt;, min_mint_amount: u256, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity"></a>

## Function `remove_liquidity`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity">remove_liquidity</a>(pool: <b>address</b>, amount: u64, min_amounts: <a href="">vector</a>&lt;u256&gt;, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_imbalance"></a>

## Function `remove_liquidity_imbalance`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_imbalance">remove_liquidity_imbalance</a>(pool: <b>address</b>, amounts: <a href="">vector</a>&lt;u256&gt;, max_burn_amount: u256, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_one_coin"></a>

## Function `remove_liquidity_one_coin`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_remove_liquidity_one_coin">remove_liquidity_one_coin</a>(pool: <b>address</b>, amount: u256, i: u64, min_amount: u256, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_input"></a>

## Function `swap_exact_input`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_input">swap_exact_input</a>(path: <a href="">vector</a>&lt;<b>address</b>&gt;, flag: <a href="">vector</a>&lt;u256&gt;, amount_in: u64, amount_out_min: u256, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_output"></a>

## Function `swap_exact_output`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_swap_exact_output">swap_exact_output</a>(path: <a href="">vector</a>&lt;<b>address</b>&gt;, flag: <a href="">vector</a>&lt;u256&gt;, amount_out: u64, amount_in_max: u256, sender: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ramp_a"></a>

## Function `ramp_a`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_ramp_a">ramp_a</a>(pool: <b>address</b>, future_a: u256, future_time: u256, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_stop_ramp_a"></a>

## Function `stop_ramp_a`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_stop_ramp_a">stop_ramp_a</a>(pool: <b>address</b>, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_commit_new_fee"></a>

## Function `commit_new_fee`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_commit_new_fee">commit_new_fee</a>(pool: <b>address</b>, new_fee: u256, new_admin_fee: u256, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_apply_new_fee"></a>

## Function `apply_new_fee`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_apply_new_fee">apply_new_fee</a>(pool: <b>address</b>, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_revert_new_parameters"></a>

## Function `revert_new_parameters`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_revert_new_parameters">revert_new_parameters</a>(pool: <b>address</b>, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_withdraw_admin_fees"></a>

## Function `withdraw_admin_fees`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_withdraw_admin_fees">withdraw_admin_fees</a>(pool: <b>address</b>, admin: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_kill_me"></a>

## Function `kill_me`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_kill_me">kill_me</a>(admin: &<a href="">signer</a>, pool: <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_unkill_me"></a>

## Function `unkill_me`



<pre><code><b>public</b> entry <b>fun</b> <a href="router.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_unkill_me">unkill_me</a>(admin: &<a href="">signer</a>, pool: <b>address</b>)
</code></pre>
