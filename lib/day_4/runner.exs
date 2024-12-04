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

# Find and visualize crosses
crosses = Day4.parse_input_find_crosses(input)
IO.puts("Number of crosses found: #{length(crosses)}")
