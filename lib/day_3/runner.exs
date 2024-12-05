alias AdventOfCode2024.Day3

example_input = File.read!("lib/day_3/input.example.txt")

Day3.part_one(example_input) |> IO.inspect(label: "Example Input - Part 1")

Day3.part_two(example_input)
|> IO.inspect(label: "Example Input - Part 2")

input = File.read!("lib/day_3/input.txt")

Day3.part_one(input) |> IO.inspect(label: "Input - Part 1")

Day3.part_two(input)
|> IO.inspect(label: "Input - Part 2")
