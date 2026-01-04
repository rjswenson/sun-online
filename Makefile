.PHONY: help setup run-elixir run-python test clean

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

test: ## Run tests
	mix test
	cd python && pytest

clean: ## Clean build artifacts
	mix clean
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
