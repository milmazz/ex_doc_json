defmodule ExDocJson.MixProject do
  use Mix.Project

  @version "0.1.2"

  def project do
    [
      app: :ex_doc_json,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Creates documentation for Elixir projects in JSON format",
      package: package(),
      name: "ExDocJSON",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.30"},
      {:jason, "~> 1.4"}
    ]
  end

  defp package do
    [
      maintainers: ["Milton Mazzarri"],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/milmazz/ex_doc_json",
        "Docs" => "http://hexdocs.pm/ex_doc_json/#{@version}"
      }
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      source_ref: "v#{@version}",
      main: "readme",
      source_url: "https://github.com/milmazz/ex_doc_json"
    ]
  end
end
