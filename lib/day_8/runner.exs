alias AdventOfCode2024.Day8

input = File.read!("lib/day_8/input.txt")

parsed_input = input |> Day8.parse_input()
{input_map, size_rows, size_cols} = parsed_input

part_1_antinodes = parsed_input |> Day8.find_all_antinodes()

part_1_map = Day8.add_antinodes_to_map(input_map, part_1_antinodes)

IO.puts("input map")
Day8.print_map(input_map, size_rows, size_cols)

IO.puts("map part 1 with antinodes")
Day8.print_map(part_1_map, size_rows, size_cols)

Day8.count_antinodes(part_1_map) |> IO.inspect(label: "# of antinodes part 1")

part_2_antinodes = parsed_input |> Day8.find_all_antinodes(:extended)
part_2_map = Day8.add_antinodes_to_map(input_map, part_2_antinodes)

IO.puts("map part 2 with extended antinodes")
Day8.print_map(part_2_map, size_rows, size_cols)

part_2_total_antinodes =
  Day8.count_antinodes(part_2_map)
  |> IO.inspect(label: "# of antinodes part 2")
