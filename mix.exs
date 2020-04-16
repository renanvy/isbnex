defmodule Isbn.MixProject do
  use Mix.Project

  def project do
    [
      app: :isbnex,
      version: "0.1.0",
      elixir: "~> 1.6",
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
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
