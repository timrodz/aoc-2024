defmodule AdventOfCode2024.Day1Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day1
  doctest Day1

  test "parse_prompt splits input correctly" do
    input = "1 2\n3 4"
    assert Day1.parse_prompt(input) == [["1", "2"], ["3", "4"]]
  end

  test "part_one calculates minimum differences sum" do
    input = "1 4\n2 3" |> Day1.parse_prompt()
    assert Day1.part_one(input) == 4
  end

  test "part_two counts matching numbers" do
    input = "1 1\n1 2\n2 1" |> Day1.parse_prompt()
    assert Day1.part_two(input) == 6
  end
end
