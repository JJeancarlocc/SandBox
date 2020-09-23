# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hello_jc,
  ecto_repos: [HelloJc.Repo]

# Configures the endpoint
config :hello_jc, HelloJcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m83BFeiSoD5OzDnsXvXdJLxUawGlW2GWHwwnZdLWaOHMQyjwOR2vBtyc/v6wxGcd",
  render_errors: [view: HelloJcWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HelloJc.PubSub,
  live_view: [signing_salt: "cbLRl+ns"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :hello_jc, HelloJc.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: 10
