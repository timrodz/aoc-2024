defmodule AdventOfCode2024.Day10 do
  @trail_peak 9
  @directions [
    {0, 1},
    {0, -1},
    {1, 0},
    {-1, 0}
  ]

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {character, column} ->
        {
          {row, column},
          # This isn't really needed but some of the example inputs had
          # dots (.) in them, and they're impassable parts of the trail (to be ignored)
          case character do
            "." -> nil
            _ -> String.to_integer(character)
          end
        }
      end)
    end)
    |> Map.new()
  end

  def traverse_trail_until_peak(map, start_pos, walks \\ MapSet.new()) do
    {number, {row, col}} = start_pos

    cond do
      number == @trail_peak ->
        MapSet.put(walks, start_pos)

      true ->
        @directions
        |> Enum.map(fn {dr, dc} -> {row + dr, col + dc} end)
        |> Enum.filter(fn pos ->
          case Map.get(map, pos) do
            nil -> false
            adjacent -> adjacent == number + 1
          end
        end)
        |> Enum.flat_map(&traverse_trail_until_peak(map, {number + 1, &1}))
    end
  end
end
