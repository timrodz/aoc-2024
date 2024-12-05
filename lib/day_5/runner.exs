alias AdventOfCode2024.Day5

# [rules, updates] = File.read!("lib/day_5/input.example.txt") |> Day5.parse_prompt()
[rules, updates] = File.read!("lib/day_5/input.txt") |> Day5.parse_prompt()

parsed_updates =
  updates
  |> Enum.map(fn updates ->
    updates = updates |> Enum.map(&String.to_integer/1)
    sorted_updates = Day5.sort(rules, updates)
    Day5.calc_updates(updates, sorted_updates)
  end)

parsed_updates
|> Day5.get_middle_items()
|> Enum.sum()
|> IO.inspect(label: "Part 1")

parsed_updates
|> Day5.get_middle_items(false)
|> Enum.sum()
|> IO.inspect(label: "Part 2")
