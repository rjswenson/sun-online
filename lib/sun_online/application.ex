defmodule SunOnline.Application do
  @moduledoc """
  Sun Online application entry point.
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # HTTP server
      {Plug.Cowboy, scheme: :http, plug: SunOnline.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: SunOnline.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
