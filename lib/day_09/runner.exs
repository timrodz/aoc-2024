alias AdventOfCode2024.Day9

input = File.read!("lib/day_9/input.example.txt")

list = Day9.parse_input(input)

Day9.print_list(list, "list")

list_with_optimized_file_blocks =
  Day9.move_file_blocks_from_to_first_available_space(
    list,
    list |> Enum.reject(&(&1 != nil)) |> Enum.count()
  )

Day9.print_list(list_with_optimized_file_blocks, "list_with_optimized_file_blocks")
Day9.checksum(list_with_optimized_file_blocks)

list_with_optimized_file_groups =
  Day9.move_file_groups_to_available_spaces(list, list |> Enum.at(-1))

Day9.print_list(list_with_optimized_file_groups, "list_with_optimized_file_groups")
Day9.checksum(list_with_optimized_file_groups)
