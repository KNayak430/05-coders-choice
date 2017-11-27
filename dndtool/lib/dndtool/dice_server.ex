defmodule DnDTool.Dice_Server do

  use GenServer

  alias DnDTool.Roller, as: Roller

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  ############################
  # GenServer Implementation #
  ############################

  def handle_call({ :roll, dice_string }, _from, state) do
    { :reply, Roller.roll(dice_string), state }
  end

end
