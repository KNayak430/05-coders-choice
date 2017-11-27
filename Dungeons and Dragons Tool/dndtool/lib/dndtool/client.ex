defmodule DnDTool.Client do

  alias DnDTool.Dice_Server, as: Dice
  alias DnDTool.Player_Cache_Server, as: Players
  alias DnDTool.Spell_Cache_Server, as: Spells

  def roll(dice_string) do
    GenServer.call(Dice, { :roll, dice_string })
  end

  def skill_check(bonus, dif) do
    GenServer.call(Dice, {:skill_check, bonus, dif})
  end

  def skill_check(player, skill_type, dif) do
    GenServer.call(Dice, {:skill_check, player, skill_type, dif})
  end

  def add_player(string) do
    GenServer.call(Players, { :add_player, string })
  end

  def save_players() do
    GenServer.call(Players, :save_players)
  end

  def get_player(key) do
    GenServer.call(Players, { :get_player, key })
  end

  def add_spell(string) do
    GenServer.call(Spells, { :add_spell, string })
  end

  def save_spells() do
    GenServer.call(Spells, :save_spells)
  end

  def get_spell(key) do
    GenServer.call(Spells, { :get_spell, key })
  end

  def cast_spell(spell_name, spell_dc, dmg_mod, target_name) do
    GenServer.call(Spells, { :cast_spell, spell_name, spell_dc, dmg_mod, target_name})
  end

end
