defmodule DnDTool do

  alias DnDTool.Client, as: Client

 defdelegate roll(string),            to: Client
 defdelegate add_player(string),      to: Client
 defdelegate save_players(),          to: Client
 defdelegate get_player(player_name), to: Client

end
