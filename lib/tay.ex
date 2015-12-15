defmodule Tay do
  use Application

  @term "taylor swift"

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Tay.Endpoint, []),
      # Start the Ecto repository
      worker(Tay.Repo, []),
      # Here you could define other workers and supervisors as children
      worker(Task, [fn -> Tay.ImageTweetStreamer.stream(@term) |> Enum.to_list end]),
      worker(Tay.DatabaseCleaner, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Tay.Endpoint.config_change(changed, removed)
    :ok
  end
end
