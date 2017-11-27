defmodule DMConsoleTest do
  use ExUnit.Case
  doctest DMConsole

  test "test roll bounds" do

    assert DnDTool.roll("2d8") >= 2
    assert DnDTool.roll("2d8") <= 16

    assert DnDTool.roll("1d20 + 4") >= 5
    assert DnDTool.roll("1d20 + 4") <= 24

    assert DnDTool.roll("1d20 + 4") <= 24

    bounds_test_1("3d6", 50)

  end

  test "players were added/recalled correctly" do
    DnDTool.add_player("name:Jack,dexterity:19,acrobatics:3")
    assert String.to_integer(DnDTool.get_player("Jack").dexterity) == 19

    DnDTool.add_player("name:Jill,constitution:15,deception:2")
    assert String.to_integer(DnDTool.get_player("Jill").deception) == 2
  end

  test "spells were added/recalled correctly" do
    DnDTool.add_spell("name:Cone of Frost,damage:1d8+2,save:constitution,on_save:targets take half damage")
    assert DnDTool.get_spell("Cone of Frost").damage == "1d8+2"

    DnDTool.add_spell("name:Confusion,damage:0,save:intelligence,on_save:no effect")
    assert DnDTool.get_spell("Confusion").on_save == "no effect"
  end


  def bounds_test_1("3d6", 1) do
    assert DnDTool.roll("3d6") >= 3 and DnDTool.roll("3d6") <= 18
  end

  def bounds_test_1("3d6", n) do
    assert DnDTool.roll("3d6") >= 3 and DnDTool.roll("3d6") <= 18
    bounds_test_1("3d6", n-1)
  end

end
