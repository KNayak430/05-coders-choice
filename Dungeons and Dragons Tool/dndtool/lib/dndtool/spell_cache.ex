defmodule Spell do

  defstruct name:            "Cone of Frost",
            damage:          "2d6",
            save:            "dexterity",
            on_save:    "Target takes half damage"

end

defmodule DnDTool.Spell_Cache do

  require DnDTool.Roller

  def add_spell(cache, string) do

    spell_map = string_to_spell(string)
    Map.put(cache, spell_map.name, spell_map)

  end

  def load_spells() do

    { :ok, save_text } = File.read("../dndtool/save/spells.txt")

    save_text
    |> String.split("\r\n")
    |> Enum.map(&string_to_spell/1)
    |> Enum.reduce(%{}, fn(x, acc) -> Map.put(acc, x.name, x) end)

  end

  def save_spells(cache) do

    save_text = cache
                |> Map.keys
                |> Enum.map(fn key -> spell_to_string(Map.get(cache, key)) end)
                |> Enum.join("\r\n")


    File.write("../dndtool/save/spells.txt", save_text)

  end

  def get_spell(cache, key) do
    { :ok, spell } = Map.fetch(cache, key)
    spell
  end

  def cast_spell(spell, spell_dc, dmg_mod, target) do

    { :ok, save_stat } = Map.fetch(spell, :save)
    {:ok, target_save_value} = Map.fetch(target, String.to_atom(save_stat))
    target_save_mod = div((String.to_integer(target_save_value) - 10), 2)

    IO.puts("\n---- ROLLING TARGET'S SAVING THROW ----\n")
    save_success = DnDTool.Roller.skill_check(target_save_mod,spell_dc)

    IO.puts("\n---- ROLLING SPELL DAMAGE ----\n")
    damage = DnDTool.Roller.roll("#{spell.damage} + #{dmg_mod}")

    handle_spell_outcome(spell, save_success, damage)

  end


  ####################
  # HELPER FUNCTIONS #
  ####################

  # Takes the player struct and returns a format that can be loaded and saved
  defp spell_to_string(spell_map) do

    map_text = spell_map
               |> Map.from_struct()
               |> Map.to_list
               |> Enum.map(&Tuple.to_list/1)
               |> Enum.map(fn a -> Enum.join(a, ":") end)
               |> Enum.join(",")

   "name:" <> Map.get(spell_map, :name) <> "," <> map_text

  end

  # Takes the string and returns the player data in Player format
  defp string_to_spell(string) do

    map = string
          |> String.split(",")
          |> Enum.map(fn a -> String.split(a, ":") end)
          |> Enum.reduce(%{}, fn([key, value], map) -> Map.put(map, String.to_atom(key), value) end)

    struct(Spell, map)

  end

  def handle_spell_outcome(spell, true, damage) do
    IO.puts("\nTarget's saving throw succeeded! Pre-save damage roll was #{damage}. ")
    IO.puts("#{spell.name} on successful save: #{spell.on_save}.\n" )
  end

  def handle_spell_outcome(spell, false, damage) do
    IO.puts("\nTarget's saving throw failed! Deal #{damage} damage. \n")
  end

end
