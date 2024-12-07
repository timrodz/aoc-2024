defmodule AdventOfCode2024.Day6Test do
  use ExUnit.Case
  alias AdventOfCode.Day6
  doctest Day6

  test "parse_input creates correct map" do
    input = "^.#\n.#."

    expected = %{
      {0, 0} => "^",
      {0, 1} => ".",
      {0, 2} => "#",
      {1, 0} => ".",
      {1, 1} => "#",
      {1, 2} => "."
    }

    assert Day6.parse_input(input) == expected
  end

  test "get_starting_position finds guard" do
    map = %{{0, 0} => "^"}
    assert Day6.get_starting_position(map) == {0, 0, :up}
  end

  test "get_next_clockwise_direction rotates correctly" do
    assert Day6.get_next_clockwise_direction(:up) == :right
    assert Day6.get_next_clockwise_direction(:right) == :down
    assert Day6.get_next_clockwise_direction(:down) == :left
    assert Day6.get_next_clockwise_direction(:left) == :up
  end
end
