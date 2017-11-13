defmodule DnDTool.Client do

  def roll(dice_string) do
    GenServer.call(DnDTool.Dice_Server, { :roll, dice_string })
  end


end
