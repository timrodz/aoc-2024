defmodule AdventOfCode2024.Day8 do
  @minimum_antenna_visits_for_antinode 2

  def parse_input(input) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn {character, column} -> {{row, column}, character} end)
      end)

    {{size_rows, size_cols}, _} = grid |> Enum.at(-1)

    {Map.new(grid), size_rows, size_cols}
  end

  def find_all_antinodes({map, size_rows, size_cols}, mode \\ :basic) do
    antenna_groups =
      Enum.reject(map, fn {_, character} -> character == "." end)
      |> Enum.group_by(fn {_, character} -> character end)
      |> Enum.map(fn {character, antennas} ->
        {character, Enum.map(antennas, fn {position, _} -> position end)}
      end)

    antenna_groups
    |> Enum.map(fn {character, antennas} ->
      case mode do
        :basic ->
          antinodes = get_antinodes_for_antennas(map, antennas)
          {character, antinodes}

        :extended ->
          steps_by_antenna = calculate_steps_by_antenna(antennas)

          antinodes =
            get_antinodes_for_antennas_extended({map, size_rows, size_cols}, steps_by_antenna)

          {character, antinodes}
      end
    end)
  end

  def calculate_steps_by_antenna(antennas) do
    antennas_with_index = antennas |> Enum.with_index()

    antennas_with_index
    |> Enum.map(fn {antenna_position, index} ->
      other_antennas = get_other_antenna_positions(antennas_with_index, index)
      steps = other_antennas |> Enum.map(&subtract_positions(antenna_position, &1))
      {antenna_position, steps}
    end)
    |> Map.new()
  end

  def add_positions({row_1, col_1}, {row_2, col_2}) do
    {row_1 + row_2, col_1 + col_2}
  end

  def subtract_positions({row_1, col_1}, {row_2, col_2}) do
    {row_1 - row_2, col_1 - col_2}
  end

  def get_antinodes_for_antennas(map, antennas) do
    antennas_with_index = antennas |> Enum.with_index()

    antennas_with_index
    |> Enum.flat_map(fn {current_pos, current_idx} ->
      other_antennas = get_other_antenna_positions(antennas_with_index, current_idx)

      other_antennas
      |> Enum.map(fn other_pos -> get_position_diff(current_pos, other_pos) end)
      |> Enum.filter(&Map.has_key?(map, &1))
    end)
  end

  defp get_other_antenna_positions(antennas_with_index, current_idx) do
    antennas_with_index
    |> Enum.reject(fn {_, index} -> index == current_idx end)
    |> Enum.map(fn {position, _} -> position end)
  end

  def get_position_diff({row_1, col_1}, {row_2, col_2}) do
    {diff_row, diff_col} = subtract_positions({row_1, col_1}, {row_2, col_2})
    {row_1 + diff_row, col_1 + diff_col}
  end

  def get_antinodes_for_antennas_extended({map, size_rows, size_cols}, steps_by_antenna) do
    map
    |> Enum.map(fn {position, _} -> position end)
    |> Enum.filter(&is_position_antinode?({&1, size_rows, size_cols}, steps_by_antenna))
  end

  def is_position_antinode?({start_position, size_rows, size_cols}, steps_by_antenna) do
    antennas = steps_by_antenna |> Enum.map(fn {antenna, _} -> antenna end)

    Enum.any?(steps_by_antenna, fn {target_pos, diffs} ->
      Enum.any?(diffs, fn diff ->
        # an antinode occurs at any grid position exactly in line with at least two antennas of the same frequency
        # so an antinode occurs at its own position
        target_pos == start_position or
          move_to_target_pos(
            start_position,
            {antennas, target_pos},
            {diff, size_rows, size_cols}
          ) >= @minimum_antenna_visits_for_antinode
      end)
    end)
  end

  def move_to_target_pos(
        start_pos,
        {antennas, target_pos},
        {step, size_rows, size_cols},
        visited_antennas \\ 0
      ) do
    next_pos = add_positions(start_pos, step)

    cond do
      visited_antennas >= 2 ->
        visited_antennas

      next_pos == target_pos ->
        visited_antennas + 1

      within_bounds?(next_pos, size_rows, size_cols) ->
        visited_antennas =
          if Enum.member?(antennas, next_pos), do: visited_antennas + 1, else: visited_antennas

        move_to_target_pos(
          next_pos,
          {antennas, target_pos},
          {step, size_rows, size_cols},
          visited_antennas
        )

      true ->
        0
    end
  end

  defp within_bounds?(next_pos, size_rows, size_cols) do
    {row, col} = next_pos
    row >= 0 and row < size_rows and col >= 0 and col < size_cols
  end

  def add_antinodes_to_map(map, antinode_groups) do
    Enum.reduce(antinode_groups, map, fn {_char, antinodes}, acc ->
      antinodes
      |> Enum.reduce(acc, fn new_pos, inner_acc ->
        case Map.get(inner_acc, new_pos) do
          nil -> inner_acc
          _ -> Map.put(inner_acc, new_pos, "#")
        end
      end)
    end)
  end

  def count_antinodes(map) do
    map |> Enum.count(fn {_, character} -> character == "#" end)
  end

  def print_map(map, size_rows, size_cols) do
    grid =
      for row <- 0..size_rows, col <- 0..size_cols do
        case Map.get(map, {row, col}, ".") do
          nil ->
            nil

          character ->
            {row, col, character}
        end
      end

    formatted_grid =
      grid
      |> Enum.chunk_by(fn {row, _, _} -> row end)
      |> Enum.map(fn row ->
        row
        |> Enum.map(fn {_, _, character} -> character end)
        |> Enum.join("")
      end)
      |> Enum.join("\n")

    IO.puts(formatted_grid)
  end
end
