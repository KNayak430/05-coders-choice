defmodule DnDTool.Application do

  use Application

  def start(_type, args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(DnDTool.Dice_Server, args, restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: DnDTool.Supervisor]
    Supervisor.start_link(children, opts)
    
  end
end
