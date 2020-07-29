defmodule Tokex.MixProject do
  use Mix.Project

  def project do
    [
      app: :tokex,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: "API wrapper for Tokenomy Exchange (tokenomy.com)",
      package: package(),
      docs: [extras: ["README.md"]],
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      name: :tokex,
      files: ["lib", "mix.exs"],
      maintainers: ["VirKill Almasy"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/virkillz/tokex.git"}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:jason, "~> 1.0"},
      {:earmark, ">= 0.0.0", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
