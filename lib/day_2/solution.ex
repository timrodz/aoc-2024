defmodule AdventOfCode2024.Day2 do
  @min_diff 1
  @max_diff 3

  def part_one(input) do
    IO.puts("Day 2.1 - PROMPT\n#{input}")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.map(&process/1)
    |> Enum.count(&(&1 == true))
  end

  def part_two(input) do
    IO.puts("Day 2.2 - PROMPT\n#{input}")

    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
    |> Enum.map(&process_eliminate_one/1)
    |> Enum.count(&(&1 == true))
  end

  defp process(list), do: run_checks(list)

  defp process_eliminate_one(list) do
    case run_checks(list) do
      true ->
        true

      # Iterate over the list and remove an element one by one until the match is met
      false ->
        0..(length(list) - 1)
        |> Enum.any?(fn index ->
          run_checks(List.delete_at(list, index))
        end)
    end
  end

  defp all_values_increase?(list) do
    list
    |> Enum.with_index()
    |> Enum.all?(fn {cur_num, index} ->
      case Enum.at(list, index + 1) do
        nil -> true
        next_num -> cur_num < next_num
      end
    end)
  end

  defp all_values_decrease?(list) do
    list
    |> Enum.with_index()
    |> Enum.all?(fn {cur_num, index} ->
      case Enum.at(list, index + 1) do
        nil -> true
        next_num -> cur_num > next_num
      end
    end)
  end

  defp all_difs_valid?(list) do
    list
    |> Enum.with_index()
    |> Enum.all?(fn {cur_num, index} ->
      case Enum.at(list, index + 1) do
        nil -> true
        next_num -> is_diff_valid?(abs(next_num - cur_num))
      end
    end)
  end

  defp run_checks(list) do
    (all_values_increase?(list) or all_values_decrease?(list)) and all_difs_valid?(list)
  end

  defp is_diff_valid?(diff), do: diff >= @min_diff and diff <= @max_diff
end
