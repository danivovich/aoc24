defmodule Day02 do
  @moduledoc """
  AOC2024 Day 2
  """

  @doc """
  Parse input

  ## Examples

      iex> Day02.parse("7 6 4 2 1\\n1 2 7 8 9\\n9 7 6 2 1\\n1 3 2 4 5\\n8 6 4 4 1\\n1 3 6 7 9")
      [[7, 6, 4, 2, 1], [1, 2, 7, 8, 9], [9, 7, 6, 2, 1], [1, 3, 2, 4, 5], [8, 6, 4, 4, 1], [1, 3, 6, 7, 9]]

  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce([], fn row, acc ->
      row_strings = String.split(row, " ", trim: true)

      row_ints =
        row_strings
        |> Enum.map(fn s ->
          {i, _} = Integer.parse(s)
          i
        end)

      acc ++ [row_ints]
    end)
  end

  def input do
    {:ok, contents} = File.read("inputs/day02_input.txt")
    parse(contents)
  end

  defmodule Part1 do
    @moduledoc """
    AOC2024 Day 2 Part 1
    """

    @doc """
    Readme example part1

    ## Examples

        iex> Day02.Part1.example()
        2

    """
    def example() do
      Day02.parse("7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9")
      |> safety_check()
      |> Enum.count()
    end

    def score(lists) do
      lists
      |> safety_check()
      |> Enum.count()
    end

    def safety_check(matrix) do
      Enum.map(matrix, fn row ->
        safe?(row)
      end)
      |> Enum.reject(fn v -> !v end)
    end

    def safe?(row) do
      all_increase_or_decrease?(row) &&
        Enum.all?(reasonable_changes?(row))
    end

    def all_increase_or_decrease?(row) do
      Enum.sort(row) == row || Enum.reverse(Enum.sort(row)) == row
    end

    def reasonable_changes?([]), do: true

    def reasonable_changes?([_a]), do: true

    def reasonable_changes?([a, b]) do
      v = abs(a - b)

      v >= 1 && v <= 3
    end

    def reasonable_changes?([a, b | rest]) do
      List.flatten([reasonable_changes?([a, b])] ++ [reasonable_changes?([b | rest])])
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2024 Day 2 Part 2
    """

    @doc """
    Readme example part2

    ## Examples

        iex> Day02.Part2.example()
        4

    """
    def example() do
      Day02.parse("7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9")
      |> safety_check()
      |> Enum.count()
    end

    def score(lists) do
      lists
      |> safety_check()
      |> Enum.count()
    end

    def safety_check(matrix) do
      Enum.map(matrix, fn row ->
        all = safe?(row)
        range = Range.new(0, Enum.count(row), 1)

        all ||
          Enum.any?(range, fn v ->
            row
            |> List.delete_at(v)
            |> safe?()
          end)
      end)
      |> Enum.reject(fn v -> !v end)
    end

    def safe?(row) do
      all_increase_or_decrease?(row) &&
        Enum.all?(reasonable_changes?(row))
    end

    def all_increase_or_decrease?(row) do
      Enum.sort(row) == row || Enum.reverse(Enum.sort(row)) == row
    end

    def reasonable_changes?([]), do: true

    def reasonable_changes?([_a]), do: true

    def reasonable_changes?([a, b]) do
      v = abs(a - b)
      v >= 1 && v <= 3
    end

    def reasonable_changes?([a, b | rest]) do
      List.flatten([reasonable_changes?([a, b])] ++ [reasonable_changes?([b | rest])])
    end
  end

  def part1 do
    input()
    |> Part1.score()
  end

  def part2 do
    input()
    |> Part2.score()
  end
end
