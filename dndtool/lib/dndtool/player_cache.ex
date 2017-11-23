defmodule Player do

  defstruct name:         "Steve the Potion Chugger",
            strength:      0, dexterity:       0,
            constitution:  0, wisdom:          0,
            intelligence:  0, charisma:        0,
            acrobatics:    0, animal_handling: 0,
            arcana:        0, athletics:       0,
            deception:     0, history:         0,
            insight:       0, intimidation:    0,
            investigation: 0, medicine:        0,
            nature:        0, perception:      0,
            performance:   0, persuasion:      0,
            religion:      0, sleight_of_hand: 0,
            stealth:       0, survival:        0

end

defmodule DnDTool.Player_Cache do

  def add_player(cache, string) do
    player_map = string_to_player(string)
    Map.put(cache, player_map.name, player_map)
  end

  def load_players() do

    {:ok, save_text } = File.read("save/save.txt")

    save_text
    |> String.split("\r\n")
    |> Enum.map(fn a -> String.replace(a, " ", "") end)
    |> Enum.map(&string_to_player/1)
    |> Enum.reduce(%{}, fn(x, acc) -> Map.put(acc, x.name, x) end)

  end

  def save_players(cache) do

    save_text = cache
                |> Map.keys
                |> Enum.map(fn key -> player_to_string(Map.get(cache, key)) end)
                |> Enum.join("\r\n")


    File.write("../../save/save.txt", save_text)

  end

  def get_player(cache, key) do
    cache.key
  end

  ####################
  # HELPER FUNCTIONS #
  ####################

  # Takes the player struct and returns a format that can be loaded and saved
  defp player_to_string(map) do
    map_text = map
               |> Map.from_struct()
               |> Map.to_list
               |> Enum.map(&Tuple.to_list/1)
               |> Enum.map(fn a -> Enum.join(a, ":") end)
               |> Enum.join(",")
   "name:" <> Map.get(map, :name) <> "," <> map_text
  end

  # Takes the string and returns the player data in Player format
  defp string_to_player(string) do
    map = string
          |> String.split(",") #["name:\"Bob\"", "agility:1", "strength:20"]
          |> Enum.map(fn a -> String.split(a, ":") end) #[["name","\"Bob\""], ["agility","1"], ["strength","20"]]
          |> Enum.reduce(%{}, fn([key, value], map) -> Map.put(map, String.to_atom(key), value) end)

    struct(Player, map)

  end

end
