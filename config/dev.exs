use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixir_stream, ElixirStream.Endpoint,
    http: [port: 3000],
    url: [host: "localhost"],
    debug_errors: true,
    code_reloader: true,
    check_origin: false,
    watchers: [
      node: ["node_modules/brunch/bin/brunch", "watch", cd: Path.expand("../", __DIR__)]
    ]
# Watch static and templates for browser reloading.
config :elixir_stream, ElixirStream.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :elixir_stream, :basic_auth,
  username: "admin",
  password: "admin"

config :elixir_stream, :captcha,
  secret: "6LdYuvYSAAAAAD7rvLmY8avq_Tbadi3Kpus4YlTg"

# config :extwitter, :oauth, [
#    consumer_key: "",
#    consumer_secret: "",
#    access_token: "",
#    access_token_secret: ""
#   ]

config :elixir_stream, ElixirStream.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "elixir_stream_phoenix_dev",
  hostname: "localhost",
  pool_size: 10
