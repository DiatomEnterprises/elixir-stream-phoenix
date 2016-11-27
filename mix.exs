defmodule ElixirStream.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_stream,
     version: "0.0.5",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirStream, []},
     applications: [:phoenix, :cowboy, :logger, :exrm, :earmark,
      :postgrex, :phoenix_html, :phoenix_ecto, :gettext,
      :timex, :extwitter, :oauth, :plug_basic_auth, :httpoison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.2"},
      {:phoenix_ecto, "~> 3.1.0-rc.0"},
      {:phoenix_html, "~> 2.8"},
      {:httpoison, "~> 0.10.0"},
      {:postgrex, "~> 1.0.0-rc.1"},
      {:cowboy, "~> 1.0"},
      {:comeonin, "~> 2.6"},
      {:exrm, "~> 1.0"},
      {:earmark, "~> 1.0"},
      {:timex, "~> 3.1"},
      {:gettext, "~> 0.12"},
      {:oauth, github: "tim/erlang-oauth"},
      {:extwitter, "~> 0.7.2"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:plug_basic_auth, github: "janjiss/plug_basic_auth"}
    ]
  end
  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
