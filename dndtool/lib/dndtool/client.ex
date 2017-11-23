defmodule DnDTool.Client do

  alias DnDTool.Dice_Server, as: Dice_Server
  alias DnDTool.Player_Cache_Server, as: Player_Cache_Server

  def roll(dice_string) do
    GenServer.call(Dice_Server, { :roll, dice_string })
  end

  def add_player(string) do
    GenServer.call(Player_Cache_Server, { :add_player, string })
  end

  def save_players() do
    GenServer.call(Player_Cache_Server, :save_players)
  end

  def get_player(key) do
    GenServer.call(Player_Cache_Server, { :get_player, key }) 
  end

end
