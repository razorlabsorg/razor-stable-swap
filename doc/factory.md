
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::factory`



-  [Struct `StableSwapPairInfo`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapPairInfo)
-  [Struct `StableSwapThreePoolPairInfo`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapThreePoolPairInfo)
-  [Resource `StableSwapFactory`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapFactory)
-  [Struct `NewStableSwapPairEvent`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_NewStableSwapPairEvent)
-  [Constants](#@Constants_0)
-  [Function `initialize`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_initialize)
-  [Function `is_initialized`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_is_initialized)
-  [Function `create_swap_pair`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_swap_pair)
-  [Function `create_three_pool_pair`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_three_pool_pair)
-  [Function `add_pair_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_add_pair_info)
-  [Function `get_pair_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_pair_info)
-  [Function `deconstruct_pair_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_pair_info)
-  [Function `get_three_pool_pair_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_three_pool_pair_info)
-  [Function `deconstruct_three_pool_pair_info`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_three_pool_pair_info)
-  [Function `pause`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_pause)
-  [Function `unpause`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_unpause)
-  [Function `set_admin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_set_admin)
-  [Function `claim_admin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_claim_admin)


<pre><code><b>use</b> <a href="">0x1::comparator</a>;
<b>use</b> <a href="">0x1::event</a>;
<b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::simple_map</a>;
<b>use</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::controller</a>;
<b>use</b> <a href="three_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool</a>;
<b>use</b> <a href="three_pool_deployer.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_three_pool_deployer">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::three_pool_deployer</a>;
<b>use</b> <a href="two_pool.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool</a>;
<b>use</b> <a href="two_pool_deployer.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_two_pool_deployer">0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::two_pool_deployer</a>;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapPairInfo"></a>

## Struct `StableSwapPairInfo`



<pre><code><b>struct</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapPairInfo">StableSwapPairInfo</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapThreePoolPairInfo"></a>

## Struct `StableSwapThreePoolPairInfo`



<pre><code><b>struct</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapThreePoolPairInfo">StableSwapThreePoolPairInfo</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapFactory"></a>

## Resource `StableSwapFactory`



<pre><code><b>struct</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapFactory">StableSwapFactory</a> <b>has</b> key
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_NewStableSwapPairEvent"></a>

## Struct `NewStableSwapPairEvent`



<pre><code>#[<a href="">event</a>]
<b>struct</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_NewStableSwapPairEvent">NewStableSwapPairEvent</a> <b>has</b> drop, store
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_ERROR_IDENTICAL_ADDRESSES"></a>

Identical Addresses


<pre><code><b>const</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_ERROR_IDENTICAL_ADDRESSES">ERROR_IDENTICAL_ADDRESSES</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_initialize"></a>

## Function `initialize`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_initialize">initialize</a>()
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_is_initialized"></a>

## Function `is_initialized`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_is_initialized">is_initialized</a>(): bool
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_swap_pair"></a>

## Function `create_swap_pair`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_swap_pair">create_swap_pair</a>(sender: &<a href="">signer</a>, tokenA: <b>address</b>, tokenB: <b>address</b>, a: u256, fee: u256, admin_fee: u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_three_pool_pair"></a>

## Function `create_three_pool_pair`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_create_three_pool_pair">create_three_pool_pair</a>(sender: &<a href="">signer</a>, tokenA: <b>address</b>, tokenB: <b>address</b>, tokenC: <b>address</b>, a: u256, fee: u256, admin_fee: u256)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_add_pair_info"></a>

## Function `add_pair_info`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_add_pair_info">add_pair_info</a>(sender: &<a href="">signer</a>, swap_contract: <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_pair_info"></a>

## Function `get_pair_info`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_pair_info">get_pair_info</a>(tokenA: <b>address</b>, tokenB: <b>address</b>): <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapPairInfo">factory::StableSwapPairInfo</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_pair_info"></a>

## Function `deconstruct_pair_info`



<pre><code><b>public</b> <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_pair_info">deconstruct_pair_info</a>(info: <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapPairInfo">factory::StableSwapPairInfo</a>): (<b>address</b>, <b>address</b>, <b>address</b>, <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_three_pool_pair_info"></a>

## Function `get_three_pool_pair_info`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_get_three_pool_pair_info">get_three_pool_pair_info</a>(tokenA: <b>address</b>, tokenB: <b>address</b>): <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapThreePoolPairInfo">factory::StableSwapThreePoolPairInfo</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_three_pool_pair_info"></a>

## Function `deconstruct_three_pool_pair_info`



<pre><code><b>public</b> <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_deconstruct_three_pool_pair_info">deconstruct_three_pool_pair_info</a>(info: <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_StableSwapThreePoolPairInfo">factory::StableSwapThreePoolPairInfo</a>): (<b>address</b>, <b>address</b>, <b>address</b>, <b>address</b>, <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_pause"></a>

## Function `pause`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_pause">pause</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_unpause"></a>

## Function `unpause`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_unpause">unpause</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_set_admin"></a>

## Function `set_admin`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_set_admin">set_admin</a>(<a href="">account</a>: &<a href="">signer</a>, admin: <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_claim_admin"></a>

## Function `claim_admin`



<pre><code><b>public</b> entry <b>fun</b> <a href="factory.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_factory_claim_admin">claim_admin</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>
