ExUnit.start()

# Configure ExUnit for integration tests
ExUnit.configure(
  exclude: [integration: true],
  max_cases: System.schedulers_online() * 2
)
