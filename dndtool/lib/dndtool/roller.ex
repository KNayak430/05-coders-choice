defmodule DnDTool.Roller do

  # User will be able to roll a custom equation of dice following the format
  # of XdY + ... + X, where  each X represents  a number of dice and Y represents
  # the number of sides on the die. Subtraction also supported. For example,
  # "3d12 - 7" means "roll three 12-sided dice and subtract 7 from the total"

  def roll(string) do
    string
    |> IO.inspect(label: "\nGot ")
    |> to_dice_list
    |> roll_list
    |> IO.inspect(label: "\nThe final result was ")
  end

  ####################
  # HELPER FUNCTIONS #
  ####################

  defp to_dice_list(string) do
    string
    |> String.replace(" ", "")
    |> String.replace("+"," ")
    |> String.replace("-"," -")
    |> String.trim
    |> String.downcase
    |> String.split(" ")
  end

  defp roll_list([h | t]), do: roll_dice_code(h) + roll_list(t)
  defp roll_list( _ ),     do: 0

  defp roll_dice_code(dice_string) do

    IO.inspect dice_string, label: "\nRolling for "

    dice_code = String.split(dice_string, "d") |> Enum.map(&String.to_integer/1)
    handle_dice_code(dice_code)
  end

  defp  handle_dice_code([num]),        do: IO.inspect(num, label: " got ")
  defp  handle_dice_code([num, sides]), do: IO.inspect(throw_dice(num, sides), label: "  subtotal ")

  defp throw_dice(1, sides),                 do: IO.inspect(:rand.uniform(sides), label: " got ")
  defp throw_dice(-1, sides),                do: -1 * IO.inspect(:rand.uniform(sides), label: " got ")
  defp throw_dice(num, sides) when num > 1,  do: IO.inspect(:rand.uniform(sides), label: " got ") + throw_dice(num - 1, sides)
  defp throw_dice(num, sides) when num < -1, do: -1 * IO.inspect(:rand.uniform(sides), label: " got ") + throw_dice(num + 1, sides)

end
