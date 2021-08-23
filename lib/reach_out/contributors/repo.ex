defmodule ReachOut.Contributors.Repo do
  use Ecto.Repo,
    otp_app: :reach_out,
    adapter: Ecto.Adapters.MyXQL
end
