# test/garden_test.exs
defmodule Day12Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day12
  doctest Day12

  test "calculates price for simple garden" do
    input = """
    AAAA
    BBCD
    BBCC
    EEEC
    """

    assert Day12.calculate_total_price(input) == 140
  end

  test "calculates price for garden with holes" do
    input = """
    OOOOO
    OXOXO
    OOOOO
    OXOXO
    OOOOO
    """

    assert Day12.calculate_total_price(input) == 772
  end

  test "calculates price for complex garden" do
    input = """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

    assert Day12.calculate_total_price(input) == 1930
  end
end
