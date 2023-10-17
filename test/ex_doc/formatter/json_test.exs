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
    "test/fixtures/*.ex"
    |> Path.wildcard()
    |> Kernel.ParallelCompiler.compile_to_path(tmp_dir)

    true = Code.prepend_path(tmp_dir)

    [language: "fr", tmp_dir: tmp_dir] |> doc_config() |> generate_docs()

    assert %{"version" => "1.0.1", "name" => "Elixir", "language" => "fr", "items" => items} =
             tmp_dir
             |> Path.join("elixir.json")
             |> File.read!()
             |> Jason.decode!()

    assert items
           |> Map.get("modules")
           |> Enum.find(
             &match?(
               %{
                 "module" => "Elixir.CompiledWithDocs",
                 "title" => "CompiledWithDocs"
               },
               &1
             )
           )

    assert items
           |> Map.get("protocols")
           |> Enum.find(
             &match?(
               %{
                 "module" => "Elixir.CustomProtocol",
                 "title" => "CustomProtocol"
               },
               &1
             )
           )

    assert items
           |> Map.get("extras")
           |> Enum.find(
             &match?(%{"source_path" => "test/fixtures/README.md", "title" => "README"}, &1)
           )
  end
end
