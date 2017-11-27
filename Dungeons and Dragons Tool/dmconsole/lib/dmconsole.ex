defmodule DMConsole do

  defdelegate start(), to: DMConsole.Impl

end
