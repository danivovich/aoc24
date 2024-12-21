defmodule Day03 do
  @moduledoc """
  AOC2024 Day 3
  """

  @doc """
  Parse input

  ## Examples

      iex> Day03.parse("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
      "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"

  """
  def parse(input) do
    input
  end

  def input do
    {:ok, contents} = File.read("inputs/day03_input.txt")
    parse(contents)
  end

  defmodule Part1 do
    @moduledoc """
    AOC2024 Day 3 Part 1
    """

    @doc """
    Readme example part1

    ## Examples

        iex> Day03.Part1.example()
        161

    """
    def example() do
      Day03.parse("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
      |> process()
      |> Enum.sum()
    end

    def process(text) do
      Regex.scan(~r/mul\(\d+,\d+\)/, text)
      |> List.flatten()
      |> Enum.map(&process_matches/1)
    end

    defp process_matches("mul(" <> params_with_close) do
      params = String.replace(params_with_close, ")", "")
      [one, two] = String.split(params, ",")
      {a, _} = Integer.parse(one)
      {b, _} = Integer.parse(two)
      a * b
    end
  end

  defmodule Part2 do
    @moduledoc """
    AOC2024 Day 3 Part 2
    """

    @doc """
    Readme example part2

    ## Examples

        iex> Day03.Part2.example()
        48

    """
    def example() do
      Day03.parse("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
      |> process()
      |> Enum.sum()
    end

    def process(text) do
      {res, _} =
        Regex.scan(~r/(mul\(\d+,\d+\)|don't\(\)|do\(\))/, text)
        |> Enum.map(&just_matches/1)
        |> List.flatten()
        |> Enum.reduce({[], true}, fn command, acc ->
          {res, in_do} = acc
          {new_res, new_do} = process_matches(command, in_do)
          {res ++ [new_res], new_do}
        end)

      res
    end

    defp process_matches("do()", _), do: {0, true}
    defp process_matches("don't()", _), do: {0, false}

    defp process_matches("mul(" <> _params_with_close, false), do: {0, false}

    defp process_matches("mul(" <> params_with_close, true) do
      params = String.replace(params_with_close, ")", "")
      [one, two] = String.split(params, ",")
      {a, _} = Integer.parse(one)
      {b, _} = Integer.parse(two)
      {a * b, true}
    end

    defp just_matches([match, _]), do: match
  end

  def part1 do
    input()
    |> Part1.process()
    |> Enum.sum()
  end

  def part2 do
    input()
    |> Part2.process()
    |> Enum.sum()
  end
end
