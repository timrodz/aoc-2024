defmodule AdventOfCode.Day6 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {character, column} -> {{row, column}, character} end)
    end)
    |> Map.new()
  end

  def get_starting_position(map) do
    # The guard always starts moving upwards
    {{row, column}, _guard} = Enum.find(map, fn {_position, character} -> character == "^" end)
    {row, column, :up}
  end

  def walk_guard(map, position, movements \\ MapSet.new()) do
    {row, column, direction} = position
    next_position = get_next_position(map, position)
    next_movements = MapSet.put(movements, position)

    cond do
      # If the current set of movements has already been seen, that means the guard is stuck on a loop
      MapSet.member?(movements, {row, column, direction}) ->
        {unique_movements(next_movements), :loop}

      next_position == :exit ->
        {unique_movements(next_movements), :exit}

      true ->
        walk_guard(map, next_position, next_movements)
    end
  end

  def get_possible_obstrcutions(map, start_position, movements) do
    # Iterate over every movement and add a wall at its position
    movements
    |> Enum.map(fn {row, column} ->
      Map.put(map, {row, column}, "#") |> walk_guard(start_position)
    end)
  end

  def unique_movements(movements) do
    # Movements can be unique regardless of the direction
    movements |> Enum.map(fn {row, column, _dir} -> {row, column} end) |> Enum.uniq()
  end

  def get_next_position(map, {row, column, direction}) do
    {next_row, next_column} =
      case direction do
        :right -> {row, column + 1}
        :left -> {row, column - 1}
        :up -> {row - 1, column}
        :down -> {row + 1, column}
      end

    case Map.get(map, {next_row, next_column}) do
      # Position doesn't exist in the map, means they've reached their exit
      nil ->
        :exit

      "#" ->
        # Keep position but change direction
        next_direction = get_next_clockwise_direction(direction)
        {row, column, next_direction}

      _ ->
        # Change position but keep direction
        {next_row, next_column, direction}
    end
  end

  def get_next_clockwise_direction(direction) do
    case direction do
      :right -> :down
      :down -> :left
      :left -> :up
      :up -> :right
    end
  end
end
