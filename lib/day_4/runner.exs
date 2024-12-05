alias AdventOfCode2024.Day4

example_input = File.read!("lib/day_4/input.example.txt")

Day4.part_one(example_input) |> IO.inspect(label: "Example Input - Part 1")
Day4.part_two(example_input) |> IO.inspect(label: "Example Input - Part 2")

input = File.read!("lib/day_4/input.txt")

Day4.part_one(input) |> IO.inspect(label: "Input - Part 1")
Day4.part_two(input) |> IO.inspect(label: "Input - Part 2")
