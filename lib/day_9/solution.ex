defmodule AdventOfCode2024.Day9 do
  def parse_input(input) do
    input
    |> String.graphemes()
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(2)
    |> Stream.with_index()
    |> Enum.reduce([], fn {entry, index}, acc ->
      case entry do
        [file, free_spaces] ->
          block_files = Enum.map(1..file, fn _ -> index end)

          spaces =
            case free_spaces do
              0 -> []
              n -> Enum.map(1..n, fn _ -> nil end)
            end

          acc ++ block_files ++ spaces

        # Last entry of the file - will always be a file block with no spacers
        [file] ->
          block_files = Enum.map(1..file, fn _ -> index end)
          acc ++ block_files
      end
    end)
  end

  def move_file_blocks_from_to_first_available_space(list, swaps_left, file_block_index \\ -1)

  def move_file_blocks_from_to_first_available_space(list, 0, _file_block_index), do: list

  def move_file_blocks_from_to_first_available_space(list, swaps_left, file_block_index) do
    swaps_left = if swaps_left - 1 < 0, do: 0, else: swaps_left - 1

    first_space_index = Enum.find_index(list, &(&1 == nil))

    updated_list =
      list
      |> List.update_at(first_space_index, fn _ -> Enum.at(list, file_block_index) end)
      |> List.update_at(file_block_index, fn _ -> nil end)

    move_file_blocks_from_to_first_available_space(
      updated_list,
      swaps_left,
      file_block_index - 1
    )
  end

  def get_free_space_groups(list, file_id, total_files_to_move) do
    file_id_index = list |> Enum.find_index(&(&1 == file_id))

    list
    |> Enum.take(file_id_index + total_files_to_move)
    |> Enum.with_index()
    |> Enum.filter(fn {value, _index} ->
      value == nil
    end)
    |> Enum.chunk_while(
      [],
      fn {_, idx}, acc ->
        if acc == [] or hd(acc) == idx - 1 do
          {:cont, [idx | acc]}
        else
          {:cont, Enum.reverse(acc), [idx]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.filter(&(&1 != []))
  end

  def move_file_groups_to_available_spaces(list, file_id) do
    files_to_move = list |> Enum.filter(&(&1 == file_id))

    total_files_to_move = length(files_to_move)

    case file_id do
      0 ->
        list

      _ ->
        group =
          get_free_space_groups(list, file_id, total_files_to_move)
          |> Enum.map(fn group -> {group |> Enum.at(0), group} end)
          |> Enum.find(fn {_, group} -> length(group) >= total_files_to_move end)

        case group do
          nil ->
            move_file_groups_to_available_spaces(list, file_id - 1)

          {first_space_index, spaces} ->
            pre_insertions = Enum.slice(list, 0..(first_space_index - 1))

            insertions =
              spaces
              |> Enum.with_index()
              |> Enum.map(fn {_space, index} ->
                if index < total_files_to_move do
                  file_id
                else
                  nil
                end
              end)

            post_insertions =
              Enum.drop(list, first_space_index + length(spaces))
              |> Enum.map(fn value ->
                case value == file_id do
                  true -> nil
                  false -> value
                end
              end)

            move_file_groups_to_available_spaces(
              pre_insertions ++ insertions ++ post_insertions,
              file_id - 1
            )
        end
    end
  end

  def checksum(list) do
    list
    |> Enum.with_index()
    |> Enum.map(fn {value, index} ->
      case value do
        nil -> 0
        num -> num * index
      end
    end)
    |> Enum.sum()
    |> IO.inspect(label: "checksum")
  end

  def print_list(list, text \\ "list") do
    list
    |> Enum.map(fn value ->
      case value do
        nil -> "."
        _ -> value
      end
    end)
    |> Enum.join("")
    |> IO.inspect(label: text)
  end
end
