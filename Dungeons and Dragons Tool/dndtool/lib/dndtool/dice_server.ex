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

  def handle_call({ :skill_check, bonus, dif }, _from, state) do
    { :reply, Roller.skill_check(bonus, dif), state }
  end

  def handle_call({ :skill_check, player, skill_type, dif }, _from, state) do
    { :reply, Roller.skill_check(player, skill_type, dif), state }
  end

end
