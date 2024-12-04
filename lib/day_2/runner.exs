alias AdventOfCode2024.Day2

input = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

Day2.parse_prompt(input) |> IO.inspect(label: "Safe sequences")
Day2.parse_prompt_eliminate_one(input) |> IO.inspect(label: "Safe sequences (eliminating one)")
