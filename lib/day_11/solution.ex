defmodule AdventOfCode2024.Day11 do
  def parse_input(input) do
    input
    |> String.split(" ")
    |> Enum.map(&{String.to_integer(&1), 1})
    |> Map.new()
  end

  def blink(map, times_to_blink) do
    case times_to_blink do
      0 ->
        map

      _ ->
        new_map =
          Enum.reduce(map, map, fn value, acc ->
            reduce_map(acc, value)
          end)

        blink(new_map, times_to_blink - 1)
    end
  end

  def reduce_map(map, value) do
    {num, times_found} = value

    case times_found do
      # Ignore numbers that are not in the current map iteration
      0 ->
        map

      _ ->
        # Returns a list because splitting returns 2 new number
        num_to_add = get_new_num(num)

        Enum.reduce(num_to_add, map, fn key, acc ->
          Map.update(acc, key, times_found, &(&1 + times_found))
        end)
        # The current number has changed so we can assume that it's been seen at least 1 less time
        |> Map.update(num, 0, &(&1 - times_found))
    end
  end

  def get_new_num(0), do: [1]

  def get_new_num(num) do
    length = get_num_length(num)

    case is_length_even?(length) do
      true ->
        split_num(num, length)

      false ->
        multiply_num(num)
    end
  end

  def get_num_length(num) do
    floor(:math.log10(num)) + 1
  end

  def is_length_even?(length) do
    rem(length, 2) == 0
  end

  def split_num(num, num_length) do
    # https://math.stackexchange.com/questions/2984282/how-can-i-mathematically-split-up-a-3-digit-number
    divisor = floor(:math.pow(10, num_length / 2))
    first_half = div(num, divisor)
    second_half = num - first_half * divisor
    [first_half, second_half]
  end

  def multiply_num(num) do
    [num * 2024]
  end

  def count_stones(map) do
    map
    |> Map.values()
    |> Enum.sum()
  end
end
