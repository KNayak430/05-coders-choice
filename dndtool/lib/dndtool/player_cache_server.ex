defmodule DnDTool.Player_Cache_Server do

  use GenServer

  alias DnDTool.Player_Cache, as: Player_Cache

  @player_cache :player_cache

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    Agent.start_link(&Player_Cache.load_players/0, name: @player_cache)
    {:ok, state}
  end

  def handle_call({ :add_player, string }, _from, state) do
    {:reply, Player_Cache.add_player(Agent.get(@player_cache,fn a -> a end), string), state}
  end

  def handle_call(:save_players, _from, state) do
    {:reply, Player_Cache.save_players(Agent.get(@player_cache,fn a -> a end)), state}
  end

  def handle_call({ :get_player, key }, _from, state) do
    {:reply, Player_Cache.get_player(Agent.get(@player_cache,fn a -> a end), key), state}
  end

end
