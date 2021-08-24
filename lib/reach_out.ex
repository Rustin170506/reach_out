defmodule ReachOut do
  def hello do
    :world
  end

  def crawl(owner, repo) do
    ReachOut.Supervisor.start_link({})

    ReachOut.GitHub.list_commits(owner, repo)
    |> ReachOut.GitHub.filter_contributors(owner, repo)
    |> Enum.each(fn contributor ->
      ReachOut.Contributors.create_contributor(contributor)
    end)
  end

  def send_emails() do
    ReachOut.Supervisor.start_link({})

    ReachOut.Contributors.list_unsent_contributors()
    |> Enum.each(fn c ->
      ReachOut.ReachOutEmail.reach_out(c) |> ReachOut.Mailer.deliver()
      ReachOut.Contributors.mark_sent(c.email)
    end)
  end
end
