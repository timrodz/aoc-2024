defmodule AdventOfCode2024.Day7Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day7
  doctest Day7

  test "parse_input/1" do
    input = "10: 1 2 3\n20: 4 5 6"

    expected_output = [
      {10, [1, 2, 3]},
      {20, [4, 5, 6]}
    ]

    assert Day7.parse_input(input) == expected_output
  end

  test "get_equations/2" do
    sequence = [10, 19]
    permutations = ["+", "*"]

    expected_output = [
      [{10, "+"}, {19, nil}],
      [{10, "*"}, {19, nil}]
    ]

    assert Day7.get_equations(sequence, permutations) == expected_output
  end

  test "get_permutations_for_sequence/2" do
    all_possible_permutations = %{2 => ["+", "*"]}
    sequence = [10, 19]
    expected_output = ["+", "*"]

    assert Day7.get_permutations_for_sequence(all_possible_permutations, sequence) ==
             expected_output
  end

  test "parse_operations/2" do
    operations = [{10, [5, 5]}, {20, [3, 4]}]
    all_possible_permutations = %{2 => ["+", "*"]}

    expected_output = [
      {10, [5, 5], true},
      {20, [3, 4], false}
    ]

    assert Day7.parse_operations(operations, all_possible_permutations) == expected_output
  end

  test "matches_value?/2" do
    equation = [{1, "+"}, {2, nil}]
    target_value = 3
    assert Day7.matches_value?(equation, target_value) == true
  end

  test "generate_permutations/2" do
    num_numbers = 2
    operators = ["+", "*"]
    expected_output = ["+", "*"]
    assert Day7.generate_permutations(num_numbers, operators) == expected_output
  end
end
