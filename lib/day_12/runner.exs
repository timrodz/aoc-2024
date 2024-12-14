alias AdventOfCode2024.Day12

input = File.read!("lib/day_12/input.example.txt")

Day12.calculate_total_price(input)
|> IO.inspect(label: "Part 1")
