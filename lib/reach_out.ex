defmodule ReachOut do
  require Logger

  def hello do
    :world
  end

  def crawl(owner, repo) do
    ReachOut.Supervisor.start_link({})

    Logger.info("Start crawling...")

    ReachOut.GitHub.list_commits(owner, repo)
    |> ReachOut.GitHub.filter_contributors(owner, repo)
    |> Enum.each(fn contributor ->
      ReachOut.Contributors.create_contributor(contributor)
    end)

    Logger.info("End of crawling.")
  end

  def send_emails() do
    ReachOut.Supervisor.start_link({})

    Logger.info("Start sending...")

    ReachOut.Contributors.list_unsent_contributors()
    |> Enum.each(fn c ->
      ReachOut.ReachOutEmail.reach_out(c) |> ReachOut.Mailer.deliver()
      Logger.info("Send email to #{c.email}")
      ReachOut.Contributors.mark_sent(c.email)
    end)

    Logger.info("End of sending.")
  end
end
