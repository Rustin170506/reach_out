defmodule Mix.Tasks.Send do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")

    ReachOut.send_emails()
  end
end
