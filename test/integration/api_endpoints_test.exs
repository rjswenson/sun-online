defmodule SunOnline.Integration.ApiEndpointsTest do
  use ExUnit.Case, async: false
  @moduletag :integration

  @python_url "http://localhost:8000"

  describe "Python AI API endpoints" do
    test "transcribe endpoint is accessible" do
      case HTTPoison.post("#{@python_url}/api/v1/transcribe", "", [{"Content-Type", "application/json"}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["status"] == "not_implemented"
          assert data["message"] =~ "Transcription endpoint"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end

    test "process endpoint is accessible" do
      case HTTPoison.post("#{@python_url}/api/v1/process", "", [{"Content-Type", "application/json"}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["status"] == "not_implemented"
          assert data["message"] =~ "Processing endpoint"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end

    test "OpenAPI docs are available" do
      case HTTPoison.get("#{@python_url}/docs") do
        {:ok, %HTTPoison.Response{status_code: 200}} ->
          # FastAPI automatically generates docs at /docs
          assert true

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end

    test "OpenAPI schema is available" do
      case HTTPoison.get("#{@python_url}/openapi.json") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          data = Jason.decode!(body)
          assert data["info"]["title"] == "Sun Online AI API"
          assert data["info"]["version"] == "0.1.0"

        {:error, %HTTPoison.Error{reason: :econnrefused}} ->
          flunk("Python service not running on port 8000. Start with: cd python && uvicorn app.main:app")

        {:error, error} ->
          flunk("Failed to connect to Python service: #{inspect(error)}")
      end
    end
  end
end
