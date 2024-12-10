alias AdventOfCode.Day6

input = File.read!("lib/day_6/input.txt")

map = Day6.parse_input(input)

start_position = Day6.get_starting_position(map)

{guard_movements, state} = Day6.walk_guard(map, start_position)

guard_movements |> Enum.count() |> IO.inspect(label: "Part 1")

obstructions =
  Day6.get_possible_obstrcutions(map, start_position, guard_movements)

obstructions
|> Enum.filter(fn {_movements, state} -> state == :loop end)
|> Enum.count()
|> IO.inspect(label: "Part 2")
