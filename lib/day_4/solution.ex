defmodule AdventOfCode2024.Day4 do
  def parse_input_part_1(input) do
    IO.puts("PROMPT\n---\n#{input}\n---")

    # HORIZONTAL

    horizontal_lines =
      input
      |> String.split("\n")

    total_horizontal =
      horizontal_lines
      |> parse_list()
      |> IO.inspect(label: "HORIZONTAL")

    # VERTICAL

    matrix =
      horizontal_lines
      |> Enum.map(&String.graphemes/1)
      |> IO.inspect(label: "PROMPT AS MATRIX")

    vertical_lines =
      matrix
      |> transpose()
      |> Enum.map(&List.to_string/1)

    total_vertical =
      vertical_lines
      |> parse_list()
      |> IO.inspect(label: "VERTICAL")

    # DIAGONAL

    diagonal_lines =
      matrix
      |> extract_all_diagonals()
      |> Enum.map(&List.to_string/1)

    total_diagonal =
      diagonal_lines |> parse_list() |> IO.inspect(label: "DIAGONAL")

    total_horizontal + total_vertical + total_diagonal
  end

  @doc """

  ## Examples
      iex> AdventOfCode2024.Day4.horizontal("MMMSXXMASMSAMXMAS")
      2

      iex> AdventOfCode2024.Day4.horizontal("XMAS")
      1
  """
  def horizontal(input) do
    Regex.split(~r/XMAS/, input, include_captures: true)
    |> Enum.filter(&(&1 == "XMAS"))
    |> Enum.count()
  end

  @doc """

  ## Examples
      iex> AdventOfCode2024.Day4.horizontal_backward("MMMSXXMASMSAMXMAS")
      1
  """
  def horizontal_backward(input) do
    Regex.split(~r/SAMX/, input, include_captures: true)
    |> Enum.filter(&(&1 == "SAMX"))
    |> Enum.count()
  end

  @doc """
  ## Examples
      iex>AdventOfCode2024.Day4.parse_list(["XMASAMX","MMMMXMAS"])
      3
  """
  def parse_list(list) do
    list
    |> Enum.map(fn line ->
      horizontal(line) + horizontal_backward(line)
    end)
    |> Enum.sum()
  end

  def extract_all_diagonals(matrix) do
    extract_diagonals(matrix, :left) ++ extract_diagonals(matrix, :right)
  end

  defp extract_diagonals(matrix, direction) do
    rows = length(matrix)
    cols = length(Enum.at(matrix, 0))

    Enum.map(-(rows - 1)..(cols - 1), fn offset ->
      Enum.with_index(matrix)
      |> Enum.reduce([], fn {row, row_idx}, acc ->
        col_idx =
          case direction do
            :left -> row_idx + offset
            :right -> cols - 1 - (row_idx + offset)
          end

        # Check if column index is valid and the element exists
        if col_idx >= 0 and col_idx < cols do
          element = Enum.at(row, col_idx)
          if element != " ", do: [element | acc], else: acc
        else
          acc
        end
      end)
      |> Enum.reverse()
    end)
    # Filter out empty lists
    |> Enum.filter(&(&1 != []))
  end

  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def parse_input_find_crosses(matrix_str) do
    matrix =
      matrix_str
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)

    rows = length(matrix)
    cols = matrix |> Enum.at(0) |> length()

    # Don't take the last 3 because the crosses are 3x3 in length
    for r <- 0..(rows - 3),
        c <- 0..(cols - 3),
        check_cross(matrix, r, c) do
      {r, c}
    end
  end

  @doc """
  ## Examples
      iex> AdventOfCode2024.Day4.check_cross([["M", "M", "M", "S", "X", "X", "M", "A", "S", "M"],["M", "S", "A", "M", "X", "M", "S", "M", "S", "A"],["A", "M", "X", "S", "X", "M", "A", "A", "M", "M"],["M", "S", "A", "M", "A", "S", "M", "S", "M", "X"],["X", "M", "A", "S", "A", "M", "X", "A", "M", "M"],["X", "X", "A", "M", "M", "X", "X", "A", "M", "A"],["S", "M", "S", "M", "S", "A", "S", "X", "S", "S"],["S", "A", "X", "A", "M", "A", "S", "A", "A", "A"],["M", "A", "M", "M", "M", "X", "M", "M", "M", "M"],["M", "X", "M", "X", "A", "X", "M", "A", "S", "X"]], 0, 1)
      true
  """
  def check_cross(matrix, row, col) do
    top_left =
      matrix |> Enum.at(row) |> Enum.at(col)

    top_right =
      matrix
      |> Enum.at(row)
      |> Enum.at(col + 2)

    middle =
      matrix
      |> Enum.at(row + 1)
      |> Enum.at(col + 1)

    bottom_left =
      matrix
      |> Enum.at(row + 2)
      |> Enum.at(col)

    bottom_right =
      matrix
      |> Enum.at(row + 2)
      |> Enum.at(col + 2)

    check_patterns(top_left, top_right, middle, bottom_left, bottom_right)
  end

  @doc """
  ## Examples
      iex>AdventOfCode2024.Day4.check_patterns("M", "S", "A", "M", "S")
      true
      iex>AdventOfCode2024.Day4.check_patterns("S", "M", "A", "S", "M")
      true
      iex>AdventOfCode2024.Day4.check_patterns("M", "M", "A", "S", "S")
      true
      iex>AdventOfCode2024.Day4.check_patterns("S", "S", "A", "M", "M")
      true

      iex>AdventOfCode2024.Day4.check_patterns("M", "S", "A", "M", "X")
      false
      iex>AdventOfCode2024.Day4.check_patterns("M", "S", "A", "X", "M")
      false
  """
  def check_patterns(top_left, top_right, middle, bottom_left, bottom_right) do
    (top_left == "M" and top_right == "S" and middle == "A" and bottom_left == "M" and
       bottom_right == "S") ||
      (top_left == "S" and top_right == "M" and middle == "A" and bottom_left == "S" and
         bottom_right == "M") ||
      (top_left == "M" and top_right == "M" and middle == "A" and bottom_left == "S" and
         bottom_right == "S") ||
      (top_left == "S" and top_right == "S" and middle == "A" and bottom_left == "M" and
         bottom_right == "M")
  end
end
