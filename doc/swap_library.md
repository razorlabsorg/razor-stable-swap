
<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library"></a>

# Module `0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839::swap_library`



-  [Constants](#@Constants_0)
-  [Function `is_sorted_two`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_is_sorted_two)
-  [Function `sort_tokens_two`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_two)
-  [Function `sort_tokens_three`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_three)
-  [Function `sort_tokens_position`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_position)
-  [Function `ensure_account_token_store`](#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_ensure_account_token_store)


<pre><code><b>use</b> <a href="">0x1::comparator</a>;
<b>use</b> <a href="">0x1::fungible_asset</a>;
<b>use</b> <a href="">0x1::object</a>;
<b>use</b> <a href="">0x1::primary_fungible_store</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_ERROR_IDENTICAL_ADDRESSES"></a>

Identical Addresses


<pre><code><b>const</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_ERROR_IDENTICAL_ADDRESSES">ERROR_IDENTICAL_ADDRESSES</a>: u64 = 1;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_is_sorted_two"></a>

## Function `is_sorted_two`



<pre><code><b>public</b> <b>fun</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_is_sorted_two">is_sorted_two</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): bool
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_two"></a>

## Function `sort_tokens_two`



<pre><code><b>public</b> <b>fun</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_two">sort_tokens_two</a>(tokenA: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, tokenB: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="">vector</a>&lt;<a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_three"></a>

## Function `sort_tokens_three`



<pre><code><b>public</b> <b>fun</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_three">sort_tokens_three</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="">vector</a>&lt;<a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_position"></a>

## Function `sort_tokens_position`



<pre><code><b>public</b> <b>fun</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_sort_tokens_position">sort_tokens_position</a>(token0: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token1: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;, token2: <a href="_Object">object::Object</a>&lt;<a href="_Metadata">fungible_asset::Metadata</a>&gt;): <a href="">vector</a>&lt;u64&gt;
</code></pre>



<a id="0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_ensure_account_token_store"></a>

## Function `ensure_account_token_store`



<pre><code><b>public</b> <b>fun</b> <a href="swap_library.md#0x703c20063317af987ab7fc191103d7cd27369ee1322a90d23b174ee393ca9839_swap_library_ensure_account_token_store">ensure_account_token_store</a>&lt;T: key&gt;(<a href="">account</a>: <b>address</b>, pair: <a href="_Object">object::Object</a>&lt;T&gt;): <a href="_Object">object::Object</a>&lt;<a href="_FungibleStore">fungible_asset::FungibleStore</a>&gt;
</code></pre>
