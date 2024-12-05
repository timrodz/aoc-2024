defmodule AdventOfCode2024.Day1 do
  def parse_prompt(input) do
    input
    |> String.split("\n", trim: true)
    # Cleans up the input "3   4" and turns it into lists (1 per line) -> [["3", "4"]]
    |> Enum.map(&String.split/1)
  end

  defp process_input(input) do
    {left_side, right_side} =
      input
      # Grabs those inputs and turns them into integers in tuple form -> [{3, 4}]
      |> Enum.map(fn [left, right] ->
        {String.to_integer(left), String.to_integer(right)}
      end)
      # Turns every item on the left side into a list -> {[3], [4]}
      # We need to do this because every item on the left/right side needs to be sorted
      |> Enum.unzip()

    {left_side, right_side}
  end

  def part_one(input) do
    {left_side, right_side} = process_input(input)

    Enum.zip(left_side |> Enum.sort(:asc), right_side |> Enum.sort(:asc))
    |> Enum.reduce(0, fn {left, right}, acc -> abs(left - right) + acc end)
  end

  def part_two(input) do
    {left_side, right_side} = process_input(input)

    left_side
    |> Enum.map(fn left_num ->
      left_num * Enum.count(right_side, fn right_num -> left_num == right_num end)
    end)
    |> Enum.sum()
  end
end
