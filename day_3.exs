prompt_1 = ~S"mul(123,456)"
prompt_2 = ~S"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
prompt_3 = ~S"xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

defmodule Day3PartTwo do
  @regex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  def parse_prompt(input, [part: :one] \\ [part: :one]) do
    IO.puts("PROMPT part_one: #{input}")

    Regex.split(@regex, input, include_captures: true)
    |> Enum.map(&parse_input_short/1)
    |> Enum.filter(&(is_nil(&1) == false))
    |> calculate_operations()
  end

  def parse_prompt(input, part: :two) do
    IO.puts("PROMPT part_two: #{input}")

    Regex.split(@regex, input, include_captures: true)
    |> Enum.reduce({[], :enabled}, fn input, acc ->
      {list, operation} = acc

      case parse_input_short(input, operation) do
        nil -> {list, operation}
        :disabled -> {list, :disabled}
        :enabled -> {list, :enabled}
        parsed_input -> {[parsed_input | list], operation}
      end
    end)
    |> elem(0)
    |> calculate_operations()
  end

  defp calculate_operations(input) do
    input
    |> Enum.map(fn {x, y} -> multiply(x, y) end)
    |> Enum.sum()
    |> IO.inspect(label: "result")
  end

  def parse_input_short(input) do
    with [_input, x, y] <- Regex.run(@regex, input),
         {x, ""} <- Integer.parse(x),
         {y, ""} <- Integer.parse(y) do
      {x, y}
    else
      _ -> nil
    end
  end

  defp parse_input_short(input, operation) do
    with [_input, x, y] <- Regex.run(@regex, input),
         {x, ""} <- Integer.parse(x),
         {y, ""} <- Integer.parse(y) do
      case operation do
        :enabled -> {x, y}
        :disabled -> nil
      end
    else
      _ ->
        cond do
          String.contains?(input, "don't()") -> :disabled
          String.contains?(input, "do()") -> :enabled
          true -> nil
        end
    end
  end

  def multiply(x, y) do
    x * y
  end
end

Day3PartTwo.parse_prompt(prompt_1)
Day3PartTwo.parse_prompt(prompt_1, part: :two)
Day3PartTwo.parse_prompt(prompt_2)
Day3PartTwo.parse_prompt(prompt_2, part: :two)
Day3PartTwo.parse_prompt(prompt_3)
Day3PartTwo.parse_prompt(prompt_3, part: :two)
