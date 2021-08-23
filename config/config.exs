use Mix.Config

config :reach_out, ecto_repos: [ReachOut.Contributors.Repo]

config :reach_out, ReachOut.Contributors.Repo,
  database: "reach_out",
  username: "root",
  password: "password",
  hostname: "localhost"

config :reach_out, ReachOut.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: {:system, "API_KEY"}
