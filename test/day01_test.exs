defmodule Day01Test do
  use ExUnit.Case
  doctest Day01
  doctest Day01.Part1
  doctest Day01.Part2

  test "checks part 1" do
    assert Day01.part1() == 2_000_468
  end

  test "checks part 2" do
    assert Day01.part2() == 18_567_089
  end
end
