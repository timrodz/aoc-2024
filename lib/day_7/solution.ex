defmodule AdventOfCode2024.Day7 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [compare_value, sequence] = String.split(line, ": ", trim: true)

      {compare_value |> String.to_integer(),
       sequence |> String.split(" ") |> Enum.map(&String.to_integer/1)}
    end)
  end

  def get_equations(sequence, permutations) do
    permutations
    |> Enum.map(
      # Add the last number because it won't be naturally added due to the sizing constraints of the zip
      # Example: if the sequence is [10, 19] and the permutations are ["+", "*"], the zip will end up as [{10, "+}]
      &(Enum.zip(sequence, &1 |> String.graphemes()) ++ [{sequence |> Enum.at(-1), nil}])
    )
  end

  def get_permutations_for_sequence(all_possible_permutations, sequence) do
    all_possible_permutations |> Map.get(sequence |> length(), [])
  end

  def parse_operations(operations, all_possible_permutations) do
    operations
    |> Enum.map(fn {compare_value, sequence} ->
      permutations = get_permutations_for_sequence(all_possible_permutations, sequence)
      equations = get_equations(sequence, permutations)
      pass? = equations |> Enum.any?(&matches_value?(&1, compare_value))

      {compare_value, sequence, pass?}
    end)
  end

  def matches_value?(equation, compare_value) do
    {value, _} =
      equation
      # Drop the first number in the equation because it's passed in the reducer as the starting accumulator
      |> Enum.drop(1)
      |> Enum.reduce(equation |> Enum.at(0), fn {number, op}, acc ->
        {prev_num, prev_op} = acc

        value =
          case prev_op do
            "+" -> prev_num + number
            "*" -> prev_num * number
            "|" -> "#{prev_num}#{number}" |> String.to_integer()
          end

        {value, op}
      end)

    value == compare_value
  end

  def generate_permutations(num_numbers, operators) do
    operators
    |> Enum.flat_map(fn op ->
      generate_remainder(num_numbers - 1, operators, [op])
    end)
    |> Enum.map(&Enum.join/1)
  end

  defp generate_remainder(remaining_slots, operators, current_sequence) do
    if remaining_slots == 1 do
      [current_sequence]
    else
      operators
      |> Enum.flat_map(fn op ->
        generate_remainder(
          remaining_slots - 1,
          operators,
          [op | current_sequence]
        )
      end)
    end
  end
end
