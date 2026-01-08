# Sun Online Tests

This directory contains tests for the Sun Online multi-service application.

## Test Structure

```
test/
├── sun_online_test.exs           # Unit tests for Elixir application
├── integration/                   # Integration tests (multi-service)
│   ├── health_check_test.exs     # Health check tests for both services
│   └── api_endpoints_test.exs    # API endpoint tests
└── README.md                      # This file

python/tests/
└── test_main.py                   # Python FastAPI unit tests
```

## Test Types

### Unit Tests (Elixir)
Test individual Elixir modules and functions without external dependencies.

```bash
# Run Elixir unit tests
mix test --exclude integration

# Or use Makefile
make test-unit
```

### Unit Tests (Python)
Test Python FastAPI endpoints using FastAPI's test client.

```bash
# Run Python tests
cd python && pytest -v

# With coverage
cd python && pytest --cov=app --cov-report=html

# Or use Makefile
make test-python
make test-python-cov
```

### Integration Tests (Elixir + Python)
Test communication between Elixir and Python services. **Requires both services to be running.**

```bash
# Terminal 1: Start Elixir service
mix run --no-halt

# Terminal 2: Start Python service
cd python && uvicorn app.main:app --reload

# Terminal 3: Run integration tests
mix test --only integration

# Or use Makefile
make test-integration
```

## Running All Tests

```bash
# Run all tests (unit tests only, no integration)
make test

# Run everything including integration (services must be running)
make test-unit && make test-python && make test-integration
```

## Test Coverage

### Elixir Service Tests
- **Unit Tests**
  - Application startup and supervision tree
  - Router module (once implemented)
  - Business logic modules (once implemented)

- **Integration Tests** (require running services)
  - Root endpoint (`GET /`) - service info
  - Health endpoint (`GET /health`)
  - 404 handling for non-existent routes

### Python Service Tests
- **Unit Tests** (using FastAPI TestClient)
  - Root endpoint (`GET /`) - service info
  - Health endpoint (`GET /health`)
  - Transcribe endpoint (`POST /api/v1/transcribe`)
  - Process endpoint (`POST /api/v1/process`)
  - OpenAPI documentation (`GET /docs`)
  - OpenAPI schema (`GET /openapi.json`)

## CI/CD

Tests run automatically on GitHub Actions:
- **Unit tests**: Run on every push/PR
- **Integration tests**: Run with docker-compose in CI environment
- **Python tests**: Run with pytest

## Writing New Tests

### Elixir Unit Tests
```elixir
defmodule MyModuleTest do
  use ExUnit.Case

  test "description" do
    assert MyModule.my_function() == expected_result
  end
end
```

### Elixir Integration Tests
```elixir
defmodule SunOnline.Integration.MyTest do
  use ExUnit.Case, async: false
  @moduletag :integration

  test "description" do
    {:ok, response} = HTTPoison.get("http://localhost:4000/endpoint")
    assert response.status_code == 200
  end
end
```

### Python Tests
```python
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_my_endpoint():
    response = client.get("/endpoint")
    assert response.status_code == 200
    assert response.json()["key"] == "value"
```

## Troubleshooting

### Integration Tests Fail with "connection refused"
**Problem**: Integration tests cannot connect to services.

**Solution**: Ensure both services are running:
```bash
# Terminal 1
mix run --no-halt

# Terminal 2
cd python && uvicorn app.main:app --reload

# Terminal 3
mix test --only integration
```

### Python Tests Fail with Import Errors
**Problem**: Python dependencies not installed.

**Solution**: Install dependencies:
```bash
cd python
pip install -r requirements.txt
```

### Tests Pass Locally but Fail on CI
**Problem**: Environment differences between local and CI.

**Solution**: Check GitHub Actions workflow for proper service startup configuration.

## Dependencies

### Elixir Testing
- ExUnit (built-in with Elixir)
- HTTPoison (for HTTP requests in integration tests)
- Jason (for JSON parsing)

### Python Testing
- pytest
- pytest-cov (coverage reporting)
- FastAPI TestClient (built-in with FastAPI)

## Coverage Reports

### Python Coverage
After running `make test-python-cov`, open the HTML report:
```bash
open python/htmlcov/index.html  # macOS
xdg-open python/htmlcov/index.html  # Linux
```

### Elixir Coverage
To add coverage to Elixir tests, install `excoveralls`:
```elixir
# mix.exs
{:excoveralls, "~> 0.18", only: :test}
```

Then run:
```bash
mix coveralls.html
open cover/excoveralls.html
```
