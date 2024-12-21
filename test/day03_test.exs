defmodule Day03Test do
  use ExUnit.Case
  doctest Day03
  doctest Day03.Part1
  doctest Day03.Part2

  test "checks part 1" do
    assert Day03.part1() == 173_529_487
  end

  test "checks part 2" do
    assert Day03.part2() == 99_532_691
  end
end
