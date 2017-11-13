defmodule DnDTool do

 defdelegate roll(string), to: DnDTool.Client

end
