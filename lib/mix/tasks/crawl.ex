defmodule Mix.Tasks.Crawl do
  use Mix.Task

  def run(args) do
    Mix.Task.run("app.start")

    ReachOut.crawl(Enum.at(args, 0), Enum.at(args, 1))
  end
end
