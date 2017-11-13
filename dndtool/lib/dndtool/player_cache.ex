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

defmodule Player_Cache do

  def start_link() do
    Agent.start_link(fn -> load_players() end, name: __MODULE__ )
  end

  def load_players() do

    {:ok, save_text } = File.read("../../save/save.txt")
    save_text
    |> String.split("\r\n")
    |> Enum.map(fn a -> String.replace(a, " ", "") end)
    |> Enum.map(fn a -> String.split(a, ",") end)
    |> create_player_map
  end

  def create_player([name | args]) do
    Enum.reduce(args, %Player{name: String.replace_leading(name, "name:", "") }, fn(x, acc) -> put_in_struct(x, acc) end)
  end

  def create_player_map(list) do
    create_player_map(%{}, list)
  end

  def create_player_map(map, []) do
    map
  end

  def create_player_map(map, [ h | t ]) do
    create_player_map(Map.put(map, String.replace_leading(List.first(h), "name:", "" ), create_player(h)), t)
  end

  defp put_in_struct(x, acc) do
    key = x
          |> String.split(":")
          |> List.first
    value = x
          |> String.split(":")
          |> List.last

    Map.put(acc, key, value)
  end

  def save_players(cache) do
    save_text = cache
                |> Map.keys
                |> Enum.map(fn key -> stringerize(Map.get(cache, key)) end)
                |> Enum.join("\r\n")


    File.write("../../save/save.txt", save_text)

  end

  # Takes the player struct and returns a format that can be loaded and saved
  def stringerize(map) do
    map_text = map
               |> Map.from_struct()
               |> Map.to_list
               |> Enum.map(fn a -> Tuple.to_list(a) end)
               |> Enum.map(fn a -> Enum.join(a, ":") end)
               |> Enum.join(",")
   "name:" <> Map.get(map, :name) <> "," <> map_text
  end

end
