defmodule ReachOut do
  def hello do
    :world
  end

  def crawl(owner, repo) do
    ReachOut.Supervisor.start_link({})

    ReachOut.GitHub.list_commits(owner, repo)
    |> ReachOut.GitHub.filter_contributors()
    |> Enum.each(fn contributor ->
      ReachOut.Contributors.create_contributor(contributor)
    end)
  end
end
