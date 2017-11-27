defmodule DnDTool.Spell_Cache_Server do

  use GenServer

  alias DnDTool.Spell_Cache, as: Spell_Cache
  alias DnDTool.Player_Cache, as: Player_Cache

  @spell_cache :spell_cache
  @player_cache :player_cache

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  ############################
  # GenServer Implementation #
  ############################

  def init(state) do
    Agent.start_link(&Spell_Cache.load_spells/0, name: @spell_cache)
    { :ok, state }
  end

  def handle_call({ :add_spell, string }, _from, state) do
    Agent.update(@spell_cache, fn cache -> Spell_Cache.add_spell(cache, string) end)
    {:reply, Agent.get(@spell_cache, fn a -> a end) , state}
  end

  def handle_call(:save_spells, _from, state) do
    { :reply, Spell_Cache.save_spells(Agent.get(@spell_cache, fn a -> a end)), state }
  end

  def handle_call({ :get_spell, key }, _from, state) do
    { :reply, Spell_Cache.get_spell(Agent.get(@spell_cache, fn a -> a end), key), state }
  end

  def handle_call( { :cast_spell, spell_name, spell_dc, dmg_mod, target_name }, _from, state) do
    { :reply, Spell_Cache.cast_spell(Spell_Cache.get_spell(Agent.get(@spell_cache, fn a -> a end), spell_name),
      spell_dc, dmg_mod, Player_Cache.get_player(Agent.get(@player_cache, fn a -> a end), target_name)), state }
  end

end
