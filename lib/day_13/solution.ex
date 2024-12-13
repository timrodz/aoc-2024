defmodule AdventOfCode2024.Day13 do
  def parse_input(input, prize_delta \\ 0) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn [a, b, prize] ->
      [a_x, a_y] = parse_text(a)
      [b_x, b_y] = parse_text(b)
      [p_x, p_y] = parse_text(prize, "=")

      %{
        prize: {p_x + prize_delta, p_y + prize_delta},
        button_a_steps: {a_x, a_y},
        button_b_steps: {b_x, b_y}
      }
    end)
  end

  defp parse_text(button_str, char \\ "+") do
    String.split(button_str, ",")
    |> Enum.map(&(String.split(&1, char) |> Enum.at(1) |> String.to_integer()))
  end

  @doc """
  Uses Cramer's rule to solve the system of equations because it's a 2x2 system
  """
  def solve({p_x, p_y}, {a_x, a_y}, {b_x, b_y}) do
    a = (p_x * b_y - p_y * b_x) / (a_x * b_y - a_y * b_x)
    b = (a_x * p_y - p_x * a_y) / (a_x * b_y - a_y * b_x)

    cond do
      a != trunc(a) or b != trunc(b) ->
        0

      true ->
        trunc(a * 3 + b)
    end
  end
end
