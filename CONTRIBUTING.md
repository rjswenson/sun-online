# Contributing to Sun Online

## Development Setup

### Prerequisites
- Elixir 1.14+
- Erlang/OTP 25+
- Python 3.11+
- Docker (optional)

### Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/rjswenson/sun-online.git
   cd sun-online
   ```

2. **Install dependencies**
   ```bash
   make setup
   ```

3. **Run services**

   Elixir server (port 4000):
   ```bash
   make run-elixir
   ```

   Python API (port 8000):
   ```bash
   make run-python
   ```

   Or use Docker:
   ```bash
   docker-compose up
   ```

## Project Structure

```
sun-online/
├── lib/              # Elixir application code
├── config/           # Elixir configuration
├── python/           # Python FastAPI application
│   ├── app/          # FastAPI app code
│   └── tests/        # Python tests
├── test/             # Elixir tests
├── mix.exs           # Elixir dependencies
└── Makefile          # Development commands
```

## Architecture

- **Elixir**: Content server, concurrent processing, coordination
- **Python/FastAPI**: AI/ML processing, computer vision, transcription
- **Communication**: HTTP APIs between services

## Testing

```bash
make test
```

## Code Style

- **Elixir**: Follow standard Elixir conventions, run `mix format`
- **Python**: Follow PEP 8, use type hints, run `black` and `mypy`

## Submitting Changes

1. Create a feature branch
2. Make your changes
3. Run tests
4. Submit a pull request
