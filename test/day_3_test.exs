defmodule Day3Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day3
  doctest Day3

  test "part_one returns 0 for empty string" do
    assert Day3.part_one("") == 0
  end

  test "part_one handles invalid multiplication format" do
    assert Day3.part_one("mul(abc,def)") == 0
  end

  test "part_two handles disabled operations" do
    input = "mul(2,3)don't()mul(4,5)mul(6,7)"
    assert Day3.part_two(input) == 6
  end

  test "calculate_operations handles empty list" do
    assert Day3.calculate_operations([]) == 0
  end

  test "parse_input_short handles invalid number formats" do
    assert Day3.parse_input_short("mul(abc,123)") == nil
    assert Day3.parse_input_short("mul(123,def)") == nil
  end

  test "parse_input_short with operation status" do
    assert Day3.parse_input_short("mul(2,3)", :disabled) == nil
    assert Day3.parse_input_short("random text", :enabled) == nil
  end

  test "with_clause validates input format" do
    assert Day3.with_clause("not_mul(1,2)") == nil
    assert Day3.with_clause("mul(1,2") == nil
    assert Day3.with_clause("mul(999,999)") == {999, 999}
  end

  test "multiply performs basic multiplication" do
    assert Day3.multiply(5, 7) == 35
    assert Day3.multiply(0, 10) == 0
    assert Day3.multiply(-2, 3) == -6
  end
end
