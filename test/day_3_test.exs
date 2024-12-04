defmodule Day3Test do
  use ExUnit.Case
  doctest AdventOfCode2024.Day3

  # test "part_one/1" do
  #   assert Day3.part_one("mul(123,456)") == [123, 456]

  #   assert Day3.part_one(
  #            "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5)"
  #          ) ==
  #            [2, 4, 3, 7, 5, 5, 32, 64, 11, 8, 8, 5]

  #   assert Day3.part_one(
  #            "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)"
  #          ) ==
  #            [2, 4, 3, 7, 5, 5, 32, 64, 11, 8, 8, 5]
  # end

  # test "part_one/2" do
  #   assert Day3.part_one("mul(123,456)", part: :two) == [123, 456]

  #   assert Day3.part_one(
  #            "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5)",
  #            part: :two
  #          ) ==
  #            [2, 4, 3, 7, 5, 5, 32, 64, 11, 8, 8, 5]

  #   assert Day3.part_one(
  #            "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)",
  #            part: :two
  #          ) ==
  #            [2, 4, 3, 7, 5, 5, 32, 64, 11, 8, 8, 5]
  # end
end
