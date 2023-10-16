require Protocol

# Represents a Module
Protocol.derive(Jason.Encoder, ExDoc.ModuleNode,
  only: [
    :annotations,
    :deprecated,
    :doc_format,
    :doc_line,
    :docs,
    :docs_groups,
    :group,
    :language,
    :module,
    :nested_title,
    :source_doc,
    :source_path,
    :source_url,
    :title,
    :type,
    :typespecs
  ]
)

# Represents an individual type
Protocol.derive(Jason.Encoder, ExDoc.TypeNode,
  only: [
    # :spec,
    :annotations,
    :arity,
    :deprecated,
    :doc_line,
    :name,
    :rendered_doc,
    :signature,
    :source_doc,
    :source_path,
    :source_url,
    :type
  ]
)

# Represents an individual function
Protocol.derive(Jason.Encoder, ExDoc.FunctionNode,
  only: [
    # :specs,
    :annotations,
    :arity,
    # :defaults,
    :deprecated,
    :doc_line,
    :group,
    :rendered_doc,
    :signature,
    :source_doc,
    :source_path,
    :source_url,
    :type
  ]
)

defmodule ExDocJSON.ProjectNode do
  @moduledoc """
  Structure that represents a *project*

  This struct represents the top-level information of the generated JSON.

  ## Fields

  * `about` - Indicates the version of the JSON structure format.
  * `name` - Project name
  * `version` - Project version
  * `description` - Project summary description
  * `homepage_url` - Specifies the project's home page
  * `language` - Identifies the primary language of the documents.
  * `icon` - Identifies the URL of the project's logo
  * `items` - This JSON object contains modules, exceptions, protocols,
    Mix tasks, and extras details.
  """

  @derive [Jason.Encoder]
  defstruct [
    :description,
    :homepage_url,
    :icon,
    :items,
    :language,
    :name,
    :version,
    about: "ExDoc/version/1"
  ]

  @type t :: %__MODULE__{
          about: String.t(),
          description: String.t(),
          homepage_url: String.t(),
          icon: String.t(),
          items: map,
          language: String.t(),
          name: String.t(),
          version: String.t()
        }
end
