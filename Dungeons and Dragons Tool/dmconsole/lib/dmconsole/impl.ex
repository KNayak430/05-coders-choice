defmodule DMConsole.Impl do


  def start() do
      IO.puts "\nWelcome to the Dungeons and Dragons Tool! "
      get_input()
  end

  ####################
  # HELPER FUNCTIONS #
  ####################

  defp get_input() do
    IO.puts "\nAvailable commands: \n"
    IO.puts " 1. 'roll'"
    IO.puts " 2. 'skill check'"
    IO.puts " 3. 'cast spell'"
    IO.puts " 4. 'add player'"
    IO.puts " 5. 'add spell'"
    IO.puts " 6. Save & Exit"

    process_input(prompt("\nPlease enter your selection: "))

    get_input()
  end

  defp process_input("roll"),        do: get_dice_input()
  defp process_input("1"),           do: get_dice_input()
  defp process_input("skill check"), do: get_skill_check_input()
  defp process_input("2"),           do: get_skill_check_input()
  defp process_input("cast spell"),  do: get_spell_input()
  defp process_input("3"),           do: get_spell_input()
  defp process_input("add player"),  do: get_add_player_input()
  defp process_input("4"),           do: get_add_player_input()
  defp process_input("add spell"),   do: get_add_spell_input()
  defp process_input("5"),           do: get_add_spell_input()
  defp process_input("6"),           do: save_and_exit()

  defp get_dice_input() do
    prompt("Please enter enter the dice you would like to roll. \n\nDice code:  ")
      |> String.trim
      |> DnDTool.roll()
  end

  defp get_skill_check_input() do
    player = DnDTool.get_player(prompt("Please enter the player name:  "))
    skill_type = prompt(" Please enter the skill to check:  ")
    dif = prompt(" Please enter the difficulty class:  ")

    DnDTool.skill_check(player, skill_type, dif)
  end

  defp get_spell_input() do
    spell_name = prompt("Please enter the spell name: ")
    spell_dc = prompt("Please enter the spell's save DC: ") |> String.to_integer
    dmg_mod = prompt("Please enter the total damage modifier (0 for none): ") |> String.to_integer
    target_name = prompt("Please enter the name of the target: ")

    DnDTool.cast_spell(spell_name, spell_dc, dmg_mod, target_name)

  end

  defp get_add_player_input() do
    player_string = prompt("Please enter the player's information:  ")

    DnDTool.add_player(player_string)
  end

  defp get_add_spell_input() do
    spell_string = prompt("Please enter the spell's information:  ")

    DnDTool.add_spell(spell_string)
  end

  defp save_and_exit() do
    DnDTool.save_players()
    DnDTool.save_spells()
    Process.exit(self(), :exit)
  end

  defp prompt(string) do
    IO.gets("\n" <> string) |> String.trim
  end
end
