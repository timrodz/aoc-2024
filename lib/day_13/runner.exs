alias AdventOfCode2024.Day13

input = File.read!("lib/day_13/input.txt")

Day13.parse_input(input)
|> Enum.map(fn %{prize: prize, button_a_steps: button_a, button_b_steps: button_b} ->
  Day13.solve(prize, button_a, button_b)
end)
|> Enum.sum()
|> IO.inspect(label: "Part 1")

input = File.read!("lib/day_13/input.txt")

Day13.parse_input(input, 10_000_000_000_000)
|> Enum.map(fn %{prize: prize, button_a_steps: button_a, button_b_steps: button_b} ->
  Day13.solve(prize, button_a, button_b)
end)
|> Enum.sum()
|> IO.inspect(label: "Part 2")
