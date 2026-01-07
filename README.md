# Sun Online

[![Integration Tests](https://github.com/rjswenson/sun-online/actions/workflows/test.yml/badge.svg)](https://github.com/rjswenson/sun-online/actions/workflows/test.yml)

AI-powered content server using open source archives to deliver educational content with clear transcriptions.

## Overview

Sun Online is an intelligent content delivery platform that leverages artificial intelligence and machine learning to make educational content from major open source archives accessible and understandable. The system provides high-quality transcriptions and content processing for historical documents and educational materials.

## Features

- **AI-Powered Processing**: Machine learning models for content analysis and transcription
- **Multi-Archive Integration**: Connects to major educational repositories
  - Library of Congress (LoC)
  - Avalon Project
  - Fordham University archives
- **Clear Transcriptions**: Automated transcription with high accuracy
- **Scalable Architecture**: Built with Elixir for concurrent processing
- **Computer Vision**: Advanced image and document processing capabilities

## Tech Stack

- **Backend**: Elixir (concurrent, fault-tolerant server)
- **AI/ML**: Python (machine learning, computer vision)
- **API Framework**: FastAPI (high-performance Python API)
- **Testing**: ExUnit (Elixir), Pytest (Python)
- **CI/CD**: GitHub Actions
- **Focus**: Educational content, transcription, accessibility

## Project Status

**Featured Project** - Active development

This is a production application serving educational content through AI-powered processing and transcription services.

## Links

- **Live Site**: [7un.online](https://7un.online)
- **Portfolio**: Featured on [7un.me](https://7un.me)

## About the Project

Sun Online bridges the gap between historical archives and modern accessibility by applying AI and machine learning to open source educational content. The platform makes valuable historical documents and educational materials more accessible through automated transcription and content processing, serving researchers, educators, and students.

## Tags

`AI/ML` `Elixir` `Python` `Computer Vision` `FastAPI` `Education` `Transcription` `Open Source` `Archives` `Content Server`

## Local Deployment

Sun Online is a hybrid application with both Elixir and Python components. Docker is recommended for local development to manage the multi-service architecture.

### Prerequisites

- **Elixir** 1.14+ and Erlang/OTP 25+
- **Python** 3.11+
- **Docker** and Docker Compose (recommended)
- **System Libraries** for computer vision:
  - OpenCV dependencies
  - Image processing libraries

### Installation

#### Option 1: Docker (Recommended)

```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d
```

#### Option 2: Manual Setup

**Elixir Service:**
```bash
# Install dependencies
mix deps.get

# Compile
mix compile

# Start server
mix run --no-halt
```

**Python Service:**
```bash
cd python

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start FastAPI server
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Environment Variables

Create a `.env` file:

```env
# Elixir Configuration
MIX_ENV=dev
PORT=4000

# Python/FastAPI Configuration
PYTHON_ENV=development
API_PORT=8000

# Archive API Keys (if required)
LOC_API_KEY=your_library_of_congress_key
ARCHIVE_API_KEY=your_archive_api_key

# ML Model Configuration
MODEL_PATH=/path/to/models
VISION_MODEL=default
```

### Development

```bash
# Elixir service (default port 4000)
mix run --no-halt

# Python FastAPI service (default port 8000)
cd python && uvicorn main:app --reload
```

Visit:
- Elixir service: [http://localhost:4000](http://localhost:4000)
- Python API: [http://localhost:8000](http://localhost:8000)
- API docs: [http://localhost:8000/docs](http://localhost:8000/docs)

### Testing

Sun Online has comprehensive test coverage for both Elixir and Python services.

#### Quick Start

```bash
# Run all unit tests (Elixir + Python)
make test

# Run individual test suites
make test-unit          # Elixir unit tests only
make test-python        # Python tests
make test-python-cov    # Python tests with coverage
make test-integration   # Integration tests (requires running services)
```

#### Test Types

**Unit Tests** - Test individual components without external dependencies:
```bash
# Elixir unit tests
mix test --exclude integration

# Python unit tests
cd python && pytest -v
```

**Integration Tests** - Test multi-service communication (requires both services running):
```bash
# Terminal 1: Start Elixir service
mix run --no-halt

# Terminal 2: Start Python service
cd python && uvicorn app.main:app --reload

# Terminal 3: Run integration tests
mix test --only integration
```

#### Test Coverage

- **Elixir**: 1 unit test, 8 integration tests
  - Application startup and supervision
  - Health check endpoints
  - Service communication
  - API endpoint accessibility

- **Python**: 7 unit tests
  - FastAPI endpoint responses
  - Health checks
  - OpenAPI documentation
  - Transcription and processing endpoints

See [test/README.md](test/README.md) for detailed testing documentation.

#### CI/CD

Tests run automatically on GitHub Actions for every push and pull request:
- Unit tests (Elixir and Python)
- Integration tests with multi-service orchestration
- Python code coverage reporting

### Production Deployment

This application can be deployed to:

**Recommended Platforms:**
- **Fly.io** - Native support for Elixir, multi-service deployments
- **Railway** - Easy multi-service deployment with Docker
- **AWS ECS/Fargate** - Container orchestration for production scale
- **Traditional VPS** - Full control with Docker Compose

**Deployment Considerations:**
- Requires container orchestration for Elixir + Python services
- Computer vision libraries need adequate CPU/RAM resources
- Consider GPU acceleration for ML model inference at scale
- ML models may require persistent storage or S3 integration
