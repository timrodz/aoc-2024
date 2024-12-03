input = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

defmodule ReportChecker do
  @min_diff 1
  @max_diff 3

  def process(list) do
    run_checks(list)
  end

  def process(list, false) do
    run_checks(list)
  end

  def process(list, true) do
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

String.split(input, "\n")
|> Enum.map(&String.split/1)
|> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
|> Enum.map(&ReportChecker.process(&1, true))
|> Enum.count(&(&1 == true))
|> IO.inspect(label: "Safe sequences")
