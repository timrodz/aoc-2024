alias AdventOfCode2024.Day2

input_example = File.read!("lib/day_2/input.example.txt")

Day2.part_one(input_example) |> IO.inspect(label: "Example - Part 1")
Day2.part_two(input_example) |> IO.inspect(label: "Example - Part 2")

input = File.read!("lib/day_2/input.txt")

Day2.part_one(input) |> IO.inspect(label: "Part 1")
Day2.part_two(input) |> IO.inspect(label: "Part 2")
