defmodule ChasingStamps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChasingStampsWeb.Telemetry,
      ChasingStamps.Repo,
      {DNSCluster, query: Application.get_env(:chasing_stamps, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChasingStamps.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ChasingStamps.Finch},
      # Start a worker by calling: ChasingStamps.Worker.start_link(arg)
      # {ChasingStamps.Worker, arg},
      # Start to serve requests, typically the last entry
      ChasingStampsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChasingStamps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChasingStampsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
