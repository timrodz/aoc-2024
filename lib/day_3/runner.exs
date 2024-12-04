alias AdventOfCode2024.Day3

prompt_1 = """
mul(123,456)
"""

prompt_2 = """
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
"""

prompt_3 = """
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
"""

Day3.part_one(prompt_1) |> IO.inspect(label: "Part 1")

Day3.part_two(prompt_1)
|> IO.inspect(label: "Part 2")

Day3.part_one(prompt_2) |> IO.inspect(label: "Part 1")

Day3.part_two(prompt_2)
|> IO.inspect(label: "Part 2")

Day3.part_one(prompt_3) |> IO.inspect(label: "Part 1")

Day3.part_two(prompt_3)
|> IO.inspect(label: "Part 2")
