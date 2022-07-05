# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# config :mnesia,
#   # dir: '.'
#   dir: Path.join([File.cwd!(), "/priv/mnesia"])

config :app,
  out_dir: Path.join([File.cwd!(), "/out"]),
  ecto_repos: [App.Repo]

config :app, App.Guardian,
  issuer: "app",
  # 64
  secret_key:
    "LgJSZ0BUAWuybXeftda3Wgl2pHz2araO+zbgC43e8WoBFyG47CzUT98FYiGoSoIGz8yxY8Q7n0+OUQMPY0aksg==",
  ttl: {3, :days}

config :app, AppWeb.Plug.AuthAccessPipeline,
  module: App.Guardian,
  error_handler: AppWeb.AuthErrorHanler

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  domain: System.get_env("DOMAIN") || "localhost",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: App.PubSub,
  live_view: [signing_salt: "lJgFd4sj"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :app, App.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :esbuild,
  version: "0.14.0",
  live_chat: [
    args:
      ~w(js/live_chat/app.js --bundle --target=es2017 --outdir=../priv/static/assets/live_chat/ --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :esbuild,
  version: "0.14.0",
  sw: [
    args:
      ~w(js/live_chat/load-sw.js js/live_chat/sw.js --bundle --target=es2017 --outdir=../priv/static/ --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
