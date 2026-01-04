defmodule SunOnline.MixProject do
  use Mix.Project

  def project do
    [
      app: :sun_online,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {SunOnline.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:httpoison, "~> 2.0"},
      {:timex, "~> 3.7"}
    ]
  end
end
