defmodule ReachOut.GitHub do
  def list_commits(owner, repo) do
    client = github_client()
    {200, data, _} = Tentacat.Repositories.Commits.list(client, owner, repo)
    data
  end

  def filter_contributors(commits) do
    Enum.map(commits, fn commit -> commit["commit"]["author"] end)
    |> Enum.map(fn author -> %{name: author["name"], email: author["email"]} end)
    |> Enum.uniq_by(fn %{name: _, email: email} -> email end)
    |> Enum.filter(fn %{name: name, email: email} ->
      !String.ends_with?(email, "@users.noreply.github.com") &&
        !String.length(String.trim(email)) == 0 && !String.length(String.trim(name)) == 0
    end)
  end

  defp github_client() do
    Tentacat.Client.new(%{access_token: System.get_env("GITHUB_TOKEN")})
  end
end
