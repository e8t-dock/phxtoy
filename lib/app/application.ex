defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      App.Repo,
      # Start the Telemetry supervisor
      AppWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: App.PubSub},
      # for CQRS only
      # {App.Tiny.Service.MnesiaHelper, []},
      # {App.Tiny.Service.Cache, state: %{}},
      # # {App.Tiny.Service.Server, []},
      # App.Tiny.Service.Server,
      # {App.Tiny.CQRS.EventDispatcher, []},
      # 不用 {} 需要 child_spec
      # use {Module, []} not {Module}
      # App.Tiny.CQRS.EventDispatcher,
      # Start the Endpoint (http/https)
      AppWeb.Endpoint
      # Start a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
