defmodule Isbn.MixProject do
  use Mix.Project

  def project do
    [
      app: :isbnex,
      version: "0.1.1",
      elixir: "~> 1.6",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      description: "A library to work with ISBN written in Elixir.",
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "ISBN",
      docs: docs(),
      deps: deps(),
      source_url: "https://github.com/renanvy/isbnex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp package do
    [
      name: "isbnex",
      maintainers: ["Renan Carneiro Oliveira"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/renanvy/isbnex"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp docs do
    [
      source_url: "https://github.com/renan/isbnex",
      extras: ["README.md"]
    ]
  end
end
