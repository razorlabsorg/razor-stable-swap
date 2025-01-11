
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::router_helper`



-  [Constants](#@Constants_0)
-  [Function `get_stable_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_info)
-  [Function `get_stable_amounts_in`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_amounts_in)


<pre><code><b>use</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::factory</a>;
<b>use</b> <a href="stable_swap_info.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_stable_swap_info">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::stable_swap_info</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_MAX_U256"></a>



<pre><code><b>const</b> <a href="router_helper.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_MAX_U256">MAX_U256</a>: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_ERROR_INCORRECT_LENGTH"></a>



<pre><code><b>const</b> <a href="router_helper.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_ERROR_INCORRECT_LENGTH">ERROR_INCORRECT_LENGTH</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_info"></a>

## Function `get_stable_info`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="router_helper.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_info">get_stable_info</a>(input: <b>address</b>, output: <b>address</b>, flag: u256): (u64, u64, <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_amounts_in"></a>

## Function `get_stable_amounts_in`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="router_helper.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_router_helper_get_stable_amounts_in">get_stable_amounts_in</a>(path: <a href="">vector</a>&lt;<b>address</b>&gt;, flag: <a href="">vector</a>&lt;u256&gt;, amount_out: u256): <a href="">vector</a>&lt;u256&gt;
</code></pre>
