"""
Tests for Sun Online AI API
"""

import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_root_endpoint():
    """Test the root endpoint returns service information."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["service"] == "Sun Online AI API"
    assert data["version"] == "0.1.0"
    assert data["status"] == "running"


def test_health_endpoint():
    """Test the health check endpoint."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"


def test_transcribe_endpoint():
    """Test the transcribe endpoint is accessible."""
    response = client.post("/api/v1/transcribe")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "not_implemented"
    assert "Transcription" in data["message"]


def test_process_endpoint():
    """Test the process endpoint is accessible."""
    response = client.post("/api/v1/process")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "not_implemented"
    assert "Processing" in data["message"]


def test_openapi_docs():
    """Test that OpenAPI documentation is available."""
    response = client.get("/docs")
    assert response.status_code == 200


def test_openapi_schema():
    """Test that OpenAPI schema is available."""
    response = client.get("/openapi.json")
    assert response.status_code == 200
    data = response.json()
    assert data["info"]["title"] == "Sun Online AI API"
    assert data["info"]["version"] == "0.1.0"
