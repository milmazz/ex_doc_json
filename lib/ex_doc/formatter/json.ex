defmodule ExDoc.Formatter.JSON do
  @moduledoc """
  Generates JSON documentation for Elixir projects

  The ExDoc JSON formatter starts with some information at the top:

  ## Top-level information

  * `about` - Indicates the version of the JSON structure format.
  * `name` - Project name
  * `version` - Project version
  * `description` - Project summary description
  * `homepage_url` - Specifies the project's home page
  * `language` - Identifies the primary language of the documents.
  * `icon` - Identifies the URL of the project's logo
  * `items` - This JSON object contains modules, exceptions, protocols,
    Mix tasks, and extras details.

  ## Modules, Exceptions, Protocols, Mix tasks

  Each component is an array that includes:

  * `module` - Module name
  * `title` - Module title
  * `source_doc` - Module documentation summary
  * `doc_line` - Line number where the module documentation starts
  * `source_path` - Path to the source code file in the project
  * `source_url` - URL to the source code
  * `type` - Specifies if the component is a module, exception, etc.

  ### Function, callback, and type details

  * `arity`- Function arity
  * `defaults` - Default argument values
  * `source_doc` - Function documentation
  * `doc_line` - Line number where the module documentation starts
  * `source_path` - Path to the source code file in the project
  * `source_url` - URL to the source code
  * `signature` - Indicates the function signature
  * `annotations` - Show annotations

  ## Extras

  This JSON object include the following fields:

  * `id` - Identifier
  * `title` - Document title
  * `group` - Specifies the group
  * `content` - The document content in HTML format
  """

  alias Mix.Project
  alias ExDoc.Formatter.HTML

  @spec run(
          [ExDoc.ModuleNode.t()]
          | {[ExDoc.ModuleNode.t()], [ExDoc.ModuleNode.t()]},
          ExDoc.Config.t()
        ) :: String.t()
  def run(project_nodes, config) when is_list(project_nodes) and is_map(config),
    do: run({project_nodes, []}, config)

  def run({project_nodes, _filtered_modules}, config) when is_map(config) do
    config =
      config
      |> normalize_config()
      |> output_setup()

    config
    |> create_project_node(project_nodes)
    |> Jason.encode!()
    |> then(&File.write!(config.output, &1))

    Path.relative_to_cwd(config.output)
  end

  defp normalize_config(config) do
    config
    |> Map.put(:output, Path.expand(config.output))
    |> Map.put(:name, config.project || Project.config()[:name])
    |> Map.put(:description, Project.config()[:description])
  end

  defp output_setup(config) do
    file_name = config.name |> String.downcase() |> Kernel.<>(".json")
    output = Path.join(config.output, file_name)

    if File.exists?(output) do
      File.rm!(output)
    else
      File.mkdir_p!(config.output)
    end

    %{config | output: output}
  end

  defp create_project_node(config, project_nodes) do
    project_nodes = Enum.group_by(project_nodes, & &1.type)

    %ExDocJSON.ProjectNode{
      name: config.name,
      version: config.version,
      homepage_url: config.homepage_url,
      description: config.description,
      icon: config.logo,
      items: %{
        modules: project_nodes[:module] || [],
        exceptions: project_nodes[:exception] || [],
        protocols: project_nodes[:protocol] || [],
        tasks: project_nodes[:task] || [],
        extras: config |> HTML.build_extras(".html") |> Enum.map(&Map.delete(&1, :content))
      },
      language: config.language
    }
  end
end
