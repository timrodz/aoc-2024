defmodule AdventOfCode2024.Day2Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day2
  doctest Day2

  test "part_one validates increasing sequences" do
    input = "1 2 4\n5 3 1"
    assert Day2.part_one(input) == 2
  end

  test "part_two validates sequences after removing one number" do
    input = "1 2 5\n5 2 1"
    assert Day2.part_two(input) == 2
  end

  test "invalid sequence remains invalid" do
    input = "1 5 2"
    assert Day2.part_one(input) == 0
  end
end
