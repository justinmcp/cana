defmodule Cana.MixProject do
  use Mix.Project

  def project do
    [
      app: :cana,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/justinmcp/cana"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:nimble_parsec, "~> 0.6.0", only: :dev},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:benchee, "~> 1.0", only: :test}
    ]
  end

  defp description() do
    "Simple email validator based on RFC3696"
  end

  defp package() do
    [
      files: ~w(lib/**/*.ex mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/justinmcp/cana"}
    ]
  end
end
