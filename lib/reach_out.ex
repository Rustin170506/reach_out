defmodule ReachOut do
  def hello do
    :world
  end

  def run(owner, repo) do
    ReachOut.GitHub.list_commits(owner, repo) |> ReachOut.GitHub.filter_contributors()
  end
end
