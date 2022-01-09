defmodule GitHooksContrib.MixProject do
  use Mix.Project

  @version "0.1.0"
  @repo_url "https://github.com/OldhamMade/git_hooks_contrib"

  @description File.read!("README.md")
               |> String.split(~r"<!--\s*(start|end):description\s*-->")
               |> Enum.at(1)
               |> String.replace("\n", " ")
               |> String.trim()

  def project do
    [
      app: :git_hooks_contrib,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Hex
      package: hex_package(),
      description: @description,

      # Docs
      docs: docs(),

      # Coverage
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:git_hooks, "~> 0.6.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:earmark, "~> 1.4", only: [:dev, :docs]},
      {:temp, "~> 0.4", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:inch_ex, ">= 0.0.0", only: :docs}
    ]
  end

  def hex_package do
    [
      name: "git_hooks_contrib",
      maintainers: ["Phillip Oldham"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => @repo_url},
      files: ~w(lib .formatter.exs mix.exs *.md LICENSE)
    ]
  end

  defp docs do
    [
      extras: [
        "README.md",
        {:LICENSE, [title: "License"]}
      ],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @repo_url
    ]
  end

  defp aliases do
    [
      # test: ["compile --warnings-as-errors", "test"],
      coveralls: ["coveralls.html"]
    ]
  end
end
