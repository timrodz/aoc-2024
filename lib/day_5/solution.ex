defmodule AdventOfCode2024.Day5 do
  def parse_prompt(input) do
    [rules, updates] =
      input
      |> String.split("\n\n", trim: true)

    [
      rules |> String.split("\n", trim: true),
      updates
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, ","))
    ]
  end

  def sort(rules, updates) do
    Enum.sort(updates, &compare(rules, &1, &2))
  end

  def calc_updates(updates, sorted_updates) do
    case updates == sorted_updates do
      true ->
        {updates, get_middle_item(updates), true}

      false ->
        {sorted_updates, get_middle_item(sorted_updates), false}
    end
  end

  def get_middle_items(parsed_updates, pass? \\ true) do
    parsed_updates
    |> Enum.filter(fn {_, _, pass} -> pass == pass? end)
    |> Enum.map(fn {_updates, middle_item, _pass} -> middle_item end)
  end

  def get_middle_item(updates) do
    index = ((length(updates) - 1) / 2) |> round()
    updates |> Enum.at(index)
  end

  def compare(rules, a, b) do
    if String.contains?("#{a}|#{b}", rules) do
      true
    else
      false
    end
  end
end
