defmodule AdventOfCode2024.Day8Test do
  use ExUnit.Case, async: true
  alias AdventOfCode2024.Day8
  doctest Day8

  describe "parse_input/1" do
    test "correctly parses input grid" do
      input = """
      .....
      .1.2.
      .....
      .2.1.
      .....
      """

      {map, size_rows, size_cols} = Day8.parse_input(input)

      assert size_rows == 4
      assert size_cols == 4
      assert map[{1, 1}] == "1"
      assert map[{1, 3}] == "2"
      assert map[{3, 1}] == "2"
      assert map[{3, 3}] == "1"
    end
  end

  describe "find_all_antinodes/2" do
    test "finds antinodes in basic mode" do
      input = """
      .....
      .1...
      ..1..
      .....
      .....
      """

      {map, rows, cols} = Day8.parse_input(input)
      antinodes = Day8.find_all_antinodes({map, rows, cols}, :basic)

      assert length(antinodes) == 1
      {character, positions} = List.first(antinodes)
      assert character == "1"
      assert length(positions) == 2
    end
  end

  describe "calculate_steps_by_antenna/1" do
    test "calculates correct steps between antennas" do
      antennas = [{1, 1}, {1, 3}, {3, 1}, {3, 3}]
      steps = Day8.calculate_steps_by_antenna(antennas)

      assert Map.has_key?(steps, {1, 1})
      assert Map.has_key?(steps, {3, 3})
      assert length(Map.get(steps, {1, 1})) == 3
    end
  end

  describe "position operations" do
    test "add_positions/2" do
      assert Day8.add_positions({1, 2}, {3, 4}) == {4, 6}
    end

    test "subtract_positions/2" do
      assert Day8.subtract_positions({4, 6}, {1, 2}) == {3, 4}
    end
  end

  describe "is_position_antinode?/2" do
    test "correctly identifies antinode positions" do
      steps_by_antenna = %{
        {1, 1} => [{2, 2}],
        {3, 3} => [{-2, -2}]
      }

      assert Day8.is_position_antinode?({{3, 3}, 5, 5}, steps_by_antenna) == true
    end
  end

  describe "add_antinodes_to_map/2" do
    test "correctly adds antinodes to map" do
      initial_map = %{{1, 1} => ".", {1, 2} => ".", {2, 1} => ".", {2, 2} => "."}
      antinode_groups = [{"1", [{1, 1}, {2, 2}]}]

      updated_map = Day8.add_antinodes_to_map(initial_map, antinode_groups)

      assert updated_map[{1, 1}] == "#"
      assert updated_map[{2, 2}] == "#"
    end
  end

  describe "count_antinodes/1" do
    test "correctly counts antinodes" do
      map = %{
        {0, 0} => ".",
        {0, 1} => "#",
        {1, 0} => "#",
        {1, 1} => "."
      }

      assert Day8.count_antinodes(map) == 2
    end
  end
end
