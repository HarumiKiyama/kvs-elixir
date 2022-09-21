defmodule App do
  use Application
  def start(_type, _args) do
	children = [
      KvServer.accept,
      {Task.Supervisor, [name: Bamboo.TaskSupervisorStrategy.supervisor_name()]}
    ]

    opts = [strategy: :one_for_one, name: Bamboo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
