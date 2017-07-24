# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shop,
  namespace: Shop,
  ecto_repos: [Shop.Repo]

# Configures the endpoint
config :shop, Shop.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KxcOra/wyW8aBO8DGaMeXOc7VYN4yLw8D2qawjZOc5aVMvoWB9baStwAKQyfj5z2",
  render_errors: [view: Shop.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Shop.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :shop, :cache, Shop.Cache

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
