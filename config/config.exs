use Mix.Config

config :reach_out, ReachOut.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: {:system, "API_KEY"}
