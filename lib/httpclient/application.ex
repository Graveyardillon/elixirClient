defmodule Httpclient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Httpclient.Endpoint

  def start(_type, _args) do
    """
    children = [
      # Starts a worker by calling: Httpclient.Worker.start_link(arg)
      # {Httpclient.Worker, arg}
    ]
    """

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    #opts = [strategy: :one_for_one, name: Httpclient.Supervisor]
    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      Endpoint,
      Httpclient.Users.Repo
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Httpclient.Supervisor
    ]
  end
end
