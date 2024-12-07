alias AdventOfCode2024.Day7

input = File.read!("lib/day_7/input.txt")

operations = Day7.parse_input(input)

operation_permutations =
  operations
  |> Enum.map(fn {_, sequence} -> sequence |> length() end)
  |> Enum.uniq()
  |> Enum.map(&{&1, Day7.generate_permutations(&1, ["+", "*"])})
  |> Map.new()

operation_results = Day7.parse_operations(operations, operation_permutations)

sum_of_passed_operations =
  operation_results
  |> Enum.filter(fn {_, _, pass?} -> pass? == true end)
  |> Enum.map(fn {compare_value, _, _} -> compare_value end)
  |> Enum.sum()
  |> IO.inspect(label: "Part 1")

failed_operations =
  operation_results
  |> Enum.filter(fn {_, _, pass?} -> pass? == false end)
  |> Enum.map(fn {compare_value, sequence, _} -> {compare_value, sequence} end)

failed_operation_permutations =
  operations
  |> Enum.map(fn {_, sequence} -> sequence |> length() end)
  |> Enum.uniq()
  |> Enum.map(&{&1, Day7.generate_permutations(&1, ["+", "*", "|"])})
  |> Map.new()

sum_of_failed_operations =
  failed_operations
  |> Day7.parse_operations(failed_operation_permutations)
  |> Enum.filter(fn {_, _, pass?} -> pass? == true end)
  |> Enum.map(fn {compare_value, _, _} -> compare_value end)
  |> Enum.sum()

final_result = sum_of_passed_operations + sum_of_failed_operations
IO.inspect(final_result, label: "Part 2")
