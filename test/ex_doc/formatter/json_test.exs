defmodule ExDoc.Formatter.JSONTest do
  use ExUnit.Case, async: true

  alias ExDoc.Formatter.JSON

  defp doc_config(config) do
    {tmp_dir, config} = Keyword.pop(config, :tmp_dir)

    preconfig = %ExDoc.Config{
      project: "Elixir",
      version: "1.0.1",
      formatter: "json",
      output: tmp_dir,
      source_beam: tmp_dir,
      extras: ["test/fixtures/README.md"]
    }

    struct(preconfig, config)
  end

  defp generate_docs(config) do
    config.source_beam
    |> ExDoc.Retriever.docs_from_dir(config)
    |> JSON.run(config)
  end

  @tag :tmp_dir
  test "run generates JSON content", %{tmp_dir: tmp_dir} do
    [language: "fr", tmp_dir: tmp_dir] |> doc_config() |> generate_docs()

    assert %{"version" => "1.0.1", "name" => "Elixir", "language" => "fr"} =
             tmp_dir |> Path.join("elixir.json") |> File.read!() |> Jason.decode!()
  end
end
