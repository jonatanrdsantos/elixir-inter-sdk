defmodule Inter.MixProject do
  use Mix.Project

  def project do
    [
      app: :inter,
      version: "0.1.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      name: "Inter",
      description: "Inter API SDK",
      source_url: "https://github.com/jonatanrdsantos/elixir-inter-sdk",
      package: package(),
      deps: deps()
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{
        "Documentation" => "https://developers.inter.co/",
        "GitHub" => "https://github.com/jonatanrdsantos/elixir-inter-sdk"
      }
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
      {:poison, ">= 3.0.0 and <= 6.0.0"},
      {:httpoison, "~> 2.1"},
      {:nestru, "~> 0.3.3"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
