alias AdventOfCode2024.Day7

input = File.read!("lib/day_7/input.txt")

operations = Day7.parse_input(input)

possible_permutations =
  operations
  |> Enum.map(fn {_, sequence} -> sequence |> length() end)
  |> Enum.uniq()
  |> Enum.map(&{&1, Day7.generate_permutations(&1, ["+", "*"])})
  |> Map.new()

operation_results = Day7.parse_operations(operations, possible_permutations)

part_1 =
  operation_results
  |> Enum.filter(fn {_, _, pass?} -> pass? == true end)
  |> Enum.map(fn {compare_value, _, _} -> compare_value end)
  |> Enum.sum()
  |> IO.inspect(label: "Part 1")

failed_operations =
  operation_results
  |> Enum.filter(fn {_, _, pass?} -> pass? == false end)
  |> Enum.map(fn {compare_value, sequence, _} -> {compare_value, sequence} end)

possible_failed_permutations =
  operations
  |> Enum.map(fn {_, sequence} -> sequence |> length() end)
  |> Enum.uniq()
  |> Enum.map(&{&1, Day7.generate_permutations(&1, ["+", "*", "|"])})
  |> Map.new()

part_2 =
  failed_operations
  |> Day7.parse_operations(possible_failed_permutations)
  |> Enum.filter(fn {_, _, pass?} -> pass? == true end)
  |> Enum.map(fn {compare_value, _, _} -> compare_value end)
  |> Enum.sum()

(part_1 + part_2)
|> IO.inspect(label: "Part 2")
