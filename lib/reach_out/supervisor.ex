defmodule ReachOut.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Dotenv.load()
    Mix.Task.run("loadconfig")
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [ReachOut.Contributors.Repo]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
