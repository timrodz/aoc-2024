defmodule AdventOfCode2024.Day3 do
  @regex ~r/mul\((\d{1,3}),(\d{1,3})\)/

  @doc """
  Parses the input for the first part of the challenge

  ## Examples
      iex> AdventOfCode2024.Day3.parse_prompt("mul(123,456)")
      56088

      iex> AdventOfCode2024.Day3.parse_prompt("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5)")
      161

      iex> AdventOfCode2024.Day3.parse_prompt("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)")
      161
  """
  def parse_prompt(input) do
    IO.puts("PROMPT: #{input}")

    Regex.split(@regex, input, include_captures: true)
    |> Enum.map(&parse_input_short/1)
    |> Enum.filter(&(is_nil(&1) == false))
    |> calculate_operations()
  end

  @doc """
  Parses the input for the second part of the challenge

  ## Examples
      iex> AdventOfCode2024.Day3.parse_prompt_with_operation("x")
      0

      iex> AdventOfCode2024.Day3.parse_prompt_with_operation("mul(x,y)")
      0

      iex> AdventOfCode2024.Day3.parse_prompt_with_operation("mul(123,456)")
      56088

      iex> AdventOfCode2024.Day3.parse_prompt_with_operation("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5)")
      161

      iex> AdventOfCode2024.Day3.parse_prompt_with_operation("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5)")
      48
  """
  def parse_prompt_with_operation(input) do
    IO.puts("PROMPT: #{input}")

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

  @doc """
  Calculates the result of the challenge

  ## Examples
      iex> AdventOfCode2024.Day3.calculate_operations([{123, 456}, {123, 456}])
      112176

      iex> AdventOfCode2024.Day3.calculate_operations([{2, 4}, {5, 5}, {11, 8}, {8, 5}])
      161
  """
  def calculate_operations(input) do
    input
    |> Enum.map(fn {x, y} -> multiply(x, y) end)
    |> Enum.sum()
  end

  @doc """
  Parses the input for the first part of the challenge

  ## Examples
      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)")
      {123, 456}

      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)mul(123,456)")
      nil

      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)mul(123,456)mul(123,456)")
      nil

      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)mul(123,456)mul(123,456)mul(123,456)")
      nil
  """
  def parse_input_short(input) do
    with_clause(input)
  end

  @doc """
  Parses the input for the second part of the challenge

  ## Examples

      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)", :enabled)
      {123, 456}

      iex> AdventOfCode2024.Day3.parse_input_short("mul(123,456)", :disabled)
      nil

      iex> AdventOfCode2024.Day3.parse_input_short("don't()_mul(123,456)", :enabled)
      :disabled

      iex> AdventOfCode2024.Day3.parse_input_short("do()_mul(123,456)", :enabled)
      :enabled
  """
  def parse_input_short(input, operation) do
    with {x, y} <- with_clause(input) do
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

  @doc """
  ## Examples
      iex> AdventOfCode2024.Day3.with_clause("mul(123,456)")
      {123, 456}

      iex> AdventOfCode2024.Day3.with_clause("mul(123,456)mul(123,456)")
      nil
  """
  def with_clause(input) do
    with true <- String.starts_with?(input, "mul("),
         true <- String.ends_with?(input, ")"),
         true <- String.length(input) <= String.length("mul(123,456)"),
         [_input, x, y] <- Regex.run(@regex, input),
         {x, ""} <- Integer.parse(x),
         {y, ""} <- Integer.parse(y) do
      {x, y}
    else
      _ -> nil
    end
  end

  def multiply(x, y), do: x * y
end
