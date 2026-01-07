.PHONY: help setup run-elixir run-python test test-unit test-integration test-python clean

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies (Elixir and Python)
	mix deps.get
	cd python && pip install -r requirements.txt

run-elixir: ## Run Elixir server
	mix run --no-halt

run-python: ## Run Python FastAPI server
	cd python && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test: test-unit test-python ## Run all tests (unit + Python)

test-unit: ## Run Elixir unit tests only
	mix test --exclude integration

test-integration: ## Run Elixir integration tests (requires both services running)
	@echo "⚠️  Integration tests require both Elixir and Python services to be running"
	@echo "   Terminal 1: make run-elixir"
	@echo "   Terminal 2: make run-python"
	@echo "   Terminal 3: make test-integration"
	@echo ""
	mix test --only integration

test-python: ## Run Python tests
	cd python && pytest -v

test-python-cov: ## Run Python tests with coverage
	cd python && pytest --cov=app --cov-report=html --cov-report=term

clean: ## Clean build artifacts
	mix clean
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type d -name htmlcov -exec rm -rf {} +
	find . -type d -name .pytest_cache -exec rm -rf {} +
