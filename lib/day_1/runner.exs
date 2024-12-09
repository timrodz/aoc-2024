alias AdventOfCode2024.Day1

input_example = File.read!("lib/day_1/input.example.txt") |> Day1.parse_prompt()
Day1.part_one(input_example) |> IO.inspect(label: "Example - Part 1")
Day1.part_two(input_example) |> IO.inspect(label: "Example - Part 2")

input = File.read!("lib/day_1/input.txt") |> Day1.parse_prompt()

Day1.part_one(input) |> IO.inspect(label: "Part 1")
Day1.part_two(input) |> IO.inspect(label: "Part 2")
