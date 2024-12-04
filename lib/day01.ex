defmodule Day01 do
  @moduledoc """
  AOC2024 Day 1
  """

  @doc """
  Parse input

  ## Examples

      iex> Day01.parse("3   4\\n4   3\\n2   5\\n1   3\\n3   9\\n3   3")
      {[3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]}

  """
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, fn row, acc ->
      [left, right] = String.split(row, "   ", trim: true)
      {l, _} = Integer.parse(left)
      {r, _} = Integer.parse(right)
      {existing_left, existing_right} = acc
      {existing_left ++ [l], existing_right ++ [r]}
    end)
  end

  def input do
    {:ok, contents} = File.read("inputs/day01_input.txt")
    parse(contents)
  end

  defmodule Part1 do
    @moduledoc """
    AOC2024 Day 1 Part 1
    """

    @doc """
    Readme example part1

    ## Examples

        iex> Day01.Part1.example()
        11

    """
    def example() do
      Day01.parse("3   4\n4   3\n2   5\n1   3\n3   9\n3   3")
      |> distance()
      |> Enum.sum()
    end

    def score(lists) do
      lists
      |> distance()
      |> Enum.sum()
    end

    def distance({left, right}) do
      sortedl = Enum.sort(left)
      sortedr = Enum.sort(right)

      Enum.zip(sortedl, sortedr)
      |> Enum.map(fn pair ->
        {a, b} = pair
        abs(a - b)
      end)
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2024 Day 1 Part 2
    """

    @doc """
    Readme example part2

    ## Examples

        iex> Day01.Part2.example()
        31

    """
    def example() do
      Day01.parse("3   4\n4   3\n2   5\n1   3\n3   9\n3   3")
      |> similarity()
      |> Enum.sum()
    end

    def score(lists) do
      lists
      |> similarity()
      |> Enum.sum()
    end

    def similarity({left, right}) do
      freq = Enum.frequencies(right)

      Enum.map(left, fn item ->
        count = Map.get(freq, item, 0)
        item * count
      end)
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
