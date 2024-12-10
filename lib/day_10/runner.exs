alias AdventOfCode2024.Day10

input = File.read!("lib/day_10/input.example.txt")

map = Day10.parse_input(input)

zeroes =
  map
  |> Enum.filter(fn {{_, _}, number} -> number == 0 end)

walks =
  zeroes
  |> Enum.map(fn {pos, _} ->
    Day10.traverse_trail_until_peak(map, {0, pos})
  end)

part_1 =
  walks |> Enum.map(fn walk -> Enum.uniq_by(walk, fn {number, {row, col}} -> {row, col} end) end)

part_1
|> Enum.map(fn walk -> Enum.count(walk) end)
|> Enum.sum()
|> IO.inspect(label: "Part 1")

part_2 =
  walks
  |> Enum.map(fn walk -> Enum.count(walk) end)
  |> Enum.sum()
  |> IO.inspect(label: "Part 2")
