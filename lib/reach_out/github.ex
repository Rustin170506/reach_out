defmodule ReachOut.GitHub do
  def list_commits(owner, repo) do
    client = github_client()
    {200, data, _} = Tentacat.Repositories.Commits.list(client, owner, repo)
    data
  end

  def filter_contributors(commits, owner, repo) do
    Enum.map(commits, fn commit -> commit["commit"]["author"] end)
    |> Enum.map(fn author ->
      %{owner: owner, repo: repo, name: author["name"], email: author["email"]}
    end)
    |> Enum.uniq_by(fn author -> author[:email] end)
    |> Enum.filter(fn author ->
      Regex.match?(~r/@/, author[:email]) &&
        !String.ends_with?(author[:email], "@users.noreply.github.com") &&
        String.length(String.trim(author[:email])) != 0 &&
        String.length(String.trim(author[:name])) != 0
    end)
    |> Enum.map(fn author ->
      Map.put(
        author,
        :commits,
        Enum.count(commits, fn commit ->
          commit["commit"]["author"]["email"] == author[:email] ||
            commit["commit"]["author"]["name"] == author[:name]
        end)
      )
    end)
  end

  defp github_client() do
    Tentacat.Client.new(%{access_token: System.get_env("GITHUB_TOKEN")})
  end
end
