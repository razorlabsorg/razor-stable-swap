
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool_deployer`



-  [Constants](#@Constants_0)
-  [Function `create_swap_pair`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_create_swap_pair)


<pre><code><b>use</b> <a href="">0x1::comparator</a>;
<b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_N_COINS"></a>



<pre><code><b>const</b> <a href="two_pool_deployer.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_N_COINS">N_COINS</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_ERROR_IDENTICAL_ADDRESSES"></a>

Identical Addresses


<pre><code><b>const</b> <a href="two_pool_deployer.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_ERROR_IDENTICAL_ADDRESSES">ERROR_IDENTICAL_ADDRESSES</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_create_swap_pair"></a>

## Function `create_swap_pair`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="two_pool_deployer.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer_create_swap_pair">create_swap_pair</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, a: u256, fee: u256, admin_fee: u256): <a href="_Object">object::Object</a>&lt;<a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_TwoPool">two_pool::TwoPool</a>&gt;
</code></pre>