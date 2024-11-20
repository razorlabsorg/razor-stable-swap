module razor_stable_swap::router_helper {
  use razor_stable_swap::stable_swap_factory;
  use razor_stable_swap::stable_swap_info;

  use std::vector;

  const MAX_U256: u256 = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;

  const ERROR_INCORRECT_LENGTH: u64 = 1;

  #[view]
  public fun get_stable_info(
    input: address,
    output: address,
    flag: u256,
  ): (u64, u64, address) {
    let i;
    let j;
    let swap_contract;
    if (flag == 2) {
      let info = stable_swap_factory::get_pair_info(input, output);
      let (swap, token0, _, _) = stable_swap_factory::deconstruct_pair_info(info);
      i = if (input == token0) { 0 } else { 1 };
      j = if (i == 0) { 1 } else { 0 };
      swap_contract = swap;
    } else {
      let info = stable_swap_factory::get_three_pool_pair_info(input, output);
      let (swap, token0, token1, _, _) = stable_swap_factory::deconstruct_three_pool_pair_info(info);
      if (input == token0) {
        i = 0;
      } else if (input == token1) {
        i = 1;
      } else {
        i = 2;
      };

      if (output == token0) {
        j = 0;
      } else if (output == token1) {
        j = 1;
      } else {
        j = 2;
      };
      swap_contract = swap;
    };

    (i, j, swap_contract)
  }

  #[view]
  public fun get_stable_amounts_in(
    path: vector<address>,
    flag: vector<u256>,
    amount_out: u256,
  ): vector<u256> {
    let length = vector::length(&path);

    assert!(length >= 2, ERROR_INCORRECT_LENGTH);

    let amounts = vector::empty<u256>();
    vector::push_back(&mut amounts, 0);
    vector::push_back(&mut amounts, amount_out);

    let i = length - 1;

    while (i > 0) {
      let last = i - 1;
      let (k, j, swap_contract) = get_stable_info(
        *vector::borrow(&path, last),
        *vector::borrow(&path, i),
        *vector::borrow(&flag, last)
      );

      let last_amount = stable_swap_info::get_dx(
        swap_contract,
        k,
        j,
        *vector::borrow(&amounts, i),
        MAX_U256
      );

      vector::push_back(&mut amounts, last_amount);
      i = i - 1;
    };

    return amounts
  }
}