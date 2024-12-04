alias AdventOfCode2024.Day4

input = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""

Day4.part_one(input) |> IO.inspect(label: "Part 1")
Day4.part_two(input) |> length() |> IO.inspect(label: "Part 2")
