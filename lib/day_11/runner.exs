alias AdventOfCode2024.Day11

input = File.read!("lib/day_11/input.txt")

parsed = Day11.parse_input(input)

blinked_part_1 = Day11.blink(parsed, 25)

Day11.count_stones(blinked_part_1)
|> IO.inspect(label: "Part 1 - Total Stones")

blinked_part_2 = Day11.blink(parsed, 75)

Day11.count_stones(blinked_part_2)
|> IO.inspect(label: "Part 2 - Total Stones")
