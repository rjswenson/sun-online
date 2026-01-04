defmodule SunOnline.Router do
  @moduledoc """
  HTTP router for Sun Online API.
  """

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, Jason.encode!(%{
      service: "Sun Online",
      version: "0.1.0",
      status: "running"
    }))
  end

  get "/health" do
    send_resp(conn, 200, Jason.encode!(%{status: "healthy"}))
  end

  match _ do
    send_resp(conn, 404, Jason.encode!(%{error: "Not found"}))
  end
end
