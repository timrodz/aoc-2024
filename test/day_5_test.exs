defmodule AdventOfCode2024.Day5Test do
  use ExUnit.Case
  alias AdventOfCode2024.Day5
  doctest Day5

  test "parse_prompt splits rules and updates" do
    input = "rule1\nrule2\n\nupdate1,update2\nupdate3,update4"

    assert Day5.parse_prompt(input) == [
             ["rule1", "rule2"],
             [["update1", "update2"], ["update3", "update4"]]
           ]
  end

  test "compare follows rules correctly" do
    rules = ["a|b"]
    assert Day5.compare(rules, "a", "b") == true
    assert Day5.compare(rules, "b", "c") == false
  end

  test "get_middle_item returns center element" do
    updates = ["a", "b", "c"]
    assert Day5.get_middle_item(updates) == "b"
  end
end
