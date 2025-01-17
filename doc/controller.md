
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::controller`



-  [Resource `StableSwapConfig`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_StableSwapConfig)
-  [Constants](#@Constants_0)
-  [Function `get_signer`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer)
-  [Function `get_signer_address`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer_address)
-  [Function `get_fee_to`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_to)
-  [Function `get_admin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_admin)
-  [Function `get_fee_on`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_on)
-  [Function `assert_paused`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_paused)
-  [Function `assert_unpaused`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_unpaused)
-  [Function `assert_admin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_admin)
-  [Function `pause`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_pause)
-  [Function `unpause`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_unpause)
-  [Function `set_fee_to`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_fee_to)
-  [Function `set_admin_address`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_admin_address)
-  [Function `claim_admin`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_claim_admin)


<pre><code><b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::signer</a>;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_StableSwapConfig"></a>

## Resource `StableSwapConfig`



<pre><code><b>struct</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_StableSwapConfig">StableSwapConfig</a> <b>has</b> key
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ADMIN"></a>



<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ADMIN">ADMIN</a>: <b>address</b> = 0x133e0a39bdfcf5bbde2b1f4def9f36b2842693345ccc49d6aa6f2ee8c7ccf9a;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_FORBIDDEN"></a>

Operation is not allowed


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_FORBIDDEN">ERROR_FORBIDDEN</a>: u64 = 3;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_INVALID_ADDRESS"></a>

Invalid Address


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_INVALID_ADDRESS">ERROR_INVALID_ADDRESS</a>: u64 = 5;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_NO_PENDING_ADMIN"></a>

No Pending Admin


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_NO_PENDING_ADMIN">ERROR_NO_PENDING_ADMIN</a>: u64 = 4;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_PAUSED"></a>

No operations are allowed when contract is paused


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_PAUSED">ERROR_PAUSED</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_PENDING_ADMIN_EXISTS"></a>

Pending Admin Exists


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_PENDING_ADMIN_EXISTS">ERROR_PENDING_ADMIN_EXISTS</a>: u64 = 6;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_UNPAUSED"></a>

Contract is needs to be paused first


<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_ERROR_UNPAUSED">ERROR_UNPAUSED</a>: u64 = 2;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_FEE_ADMIN"></a>



<pre><code><b>const</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_FEE_ADMIN">FEE_ADMIN</a>: <b>address</b> = 0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer"></a>

## Function `get_signer`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer">get_signer</a>(): <a href="">signer</a>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer_address"></a>

## Function `get_signer_address`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_signer_address">get_signer_address</a>(): <b>address</b>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_to"></a>

## Function `get_fee_to`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_to">get_fee_to</a>(): <b>address</b>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_admin"></a>

## Function `get_admin`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_admin">get_admin</a>(): <b>address</b>
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_on"></a>

## Function `get_fee_on`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_get_fee_on">get_fee_on</a>(): bool
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_paused"></a>

## Function `assert_paused`

Asserts that the protocol is in paused state
Aborts if protocol is not paused


<pre><code><b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_paused">assert_paused</a>()
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_unpaused"></a>

## Function `assert_unpaused`

Asserts that the protocol is not paused
Aborts if protocol is paused


<pre><code><b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_unpaused">assert_unpaused</a>()
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_admin"></a>

## Function `assert_admin`



<pre><code><b>public</b> <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_assert_admin">assert_admin</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_pause"></a>

## Function `pause`

Pauses the protocol
Can only be called by the current admin


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_pause">pause</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_unpause"></a>

## Function `unpause`

Unpauses the protocol
Can only be called by the current admin


<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_unpause">unpause</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_fee_to"></a>

## Function `set_fee_to`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_fee_to">set_fee_to</a>(<a href="">account</a>: &<a href="">signer</a>, fee_to: <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_admin_address"></a>

## Function `set_admin_address`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_set_admin_address">set_admin_address</a>(<a href="">account</a>: &<a href="">signer</a>, admin_address: <b>address</b>)
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_claim_admin"></a>

## Function `claim_admin`



<pre><code><b>public</b>(<b>friend</b>) <b>fun</b> <a href="controller.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_controller_claim_admin">claim_admin</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>
