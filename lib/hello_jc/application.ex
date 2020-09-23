defmodule HelloJc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      HelloJc.Repo,
      # Start the Telemetry supervisor
      HelloJcWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HelloJc.PubSub},
      # Start the Endpoint (http/https)
      HelloJcWeb.Endpoint
      # Start a worker by calling: HelloJc.Worker.start_link(arg)
      # {HelloJc.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelloJc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    HelloJcWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
