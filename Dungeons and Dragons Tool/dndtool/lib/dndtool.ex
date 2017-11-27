defmodule DnDTool do

  alias DnDTool.Client, as: Client

 defdelegate roll(string),                                           to: Client
 defdelegate add_player(string),                                     to: Client
 defdelegate save_players(),                                         to: Client
 defdelegate get_player(player_name),                                to: Client
 defdelegate skill_check(bonus, dif),                                to: Client
 defdelegate skill_check(player, skill_type, dif),                   to: Client
 defdelegate get_spell(spell_name),                                  to: Client
 defdelegate cast_spell(spell_name, spell_dc, dmg_mod, target_name), to: Client
 defdelegate add_spell(string),                                      to: Client
 defdelegate save_spells(),                                          to: Client

end
