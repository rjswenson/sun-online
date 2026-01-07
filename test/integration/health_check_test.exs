defmodule SunOnline.Integration.HealthCheckTest do
  use ExUnit.Case, async: false
  @moduletag :integration

  @elixir_url "http://localhost:4000"
  @python_url "http://localhost:8000"

  describe "Elixir service health checks" do
    test "root endpoint returns service information" do
      case HTTPoison.get("#{@elixir_url}/") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["service"] == "Sun Online"
          assert data["version"] == "0.1.0"
          assert data["status"] == "running"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Elixir service not running on port 4000. Start with: mix run --no-halt")

        {:error, error} ->
          flunk("Failed to connect to Elixir service: #{inspect(error)}")
      end
    end

    test "health endpoint returns healthy status" do
      case HTTPoison.get("#{@elixir_url}/health") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["status"] == "healthy"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Elixir service not running on port 4000. Start with: mix run --no-halt")

        {:error, error} ->
          flunk("Failed to connect to Elixir service: #{inspect(error)}")
      end
    end

    test "404 for non-existent routes" do
      case HTTPoison.get("#{@elixir_url}/non-existent") do
        {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
          data = Jason.decode!(body)
          assert data["error"] == "Not found"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Elixir service not running on port 4000. Start with: mix run --no-halt")

        {:error, error} ->
          flunk("Failed to connect to Elixir service: #{inspect(error)}")
      end
    end
  end

  describe "Python service health checks" do
    test "root endpoint returns service information" do
      case HTTPoison.get("#{@python_url}/") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["service"] == "Sun Online AI API"
          assert data["version"] == "0.1.0"
          assert data["status"] == "running"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end

    test "health endpoint returns healthy status" do
      case HTTPoison.get("#{@python_url}/health") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["status"] == "healthy"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end
  end
end
