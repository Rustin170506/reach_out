defmodule ReachOut.MixProject do
  use Mix.Project

  def project do
    [
      app: :reach_out,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:swoosh, "~> 1.5"},
      {:ecto_sql, "~> 3.2"},
      {:myxql, "~> 0.5.0"},
      {:tentacat, git: "https://github.com/hi-rustin/tentacat.git"},
      {:dotenv, "~> 3.0.0"}
    ]
  end
end
