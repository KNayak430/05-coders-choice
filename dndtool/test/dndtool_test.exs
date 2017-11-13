defmodule DnDToolTest do
  use ExUnit.Case
  doctest DnDTool

  test "test roll bounds" do

    assert DnDTool.roll("2d8") >= 2
    assert DnDTool.roll("2d8") <= 16

    assert DnDTool.roll("1d20 + 4") >= 5
    assert DnDTool.roll("1d20 + 4") <= 24

  end


end
