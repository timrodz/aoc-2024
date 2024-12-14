# lib/garden.ex
defmodule AdventOfCode2024.Day12 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def calculate_total_price(input) do
    grid = parse_input(input)
    dimensions = {length(grid), length(hd(grid))}

    grid
    |> find_regions(dimensions)
    |> Enum.map(&calculate_region_price/1)
    |> Enum.sum()
  end

  defp find_regions(grid, dimensions) do
    {rows, cols} = dimensions
    visited = MapSet.new()

    {regions, _visited} =
      for r <- 0..(rows - 1),
          c <- 0..(cols - 1),
          !MapSet.member?(visited, {r, c}),
          reduce: {[], visited} do
        {regions, visited} ->
          plant = plant_at(grid, r, c)
          {region, new_visited} = flood_fill(grid, dimensions, {r, c}, plant, visited)

          case region do
            [] -> {regions, new_visited}
            region -> {[region | regions], new_visited}
          end
      end

    regions
  end

  defp flood_fill(grid, dimensions, {r, c}, plant, visited) do
    cond do
      !valid_position?({r, c}, dimensions) ->
        {[], visited}

      MapSet.member?(visited, {r, c}) ->
        {[], visited}

      plant_at(grid, r, c) != plant ->
        {[], visited}

      true ->
        visited = MapSet.put(visited, {r, c})
        neighbors = [{r - 1, c}, {r + 1, c}, {r, c - 1}, {r, c + 1}]

        Enum.reduce(neighbors, {[{r, c}], visited}, fn pos, {region, visited} ->
          {new_cells, new_visited} = flood_fill(grid, dimensions, pos, plant, visited)
          {region ++ new_cells, new_visited}
        end)
    end
  end

  def plant_at(grid, r, c) do
    get_in(grid, [Access.at(r), Access.at(c)])
  end

  defp valid_position?({r, c}, {rows, cols}) do
    r >= 0 and r < rows and c >= 0 and c < cols
  end

  defp calculate_region_price(region) do
    area = length(region)
    perimeter = calculate_perimeter(region)
    area * perimeter
  end

  defp calculate_perimeter(region) do
    region_set = MapSet.new(region)

    Enum.reduce(region, 0, fn {r, c}, acc ->
      neighbors = [{r - 1, c}, {r + 1, c}, {r, c - 1}, {r, c + 1}]
      exposed_sides = Enum.count(neighbors, fn pos -> !MapSet.member?(region_set, pos) end)
      acc + exposed_sides
    end)
  end
end
