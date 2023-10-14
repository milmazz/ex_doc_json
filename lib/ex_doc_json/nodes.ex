require Protocol

# Represents a Module
Protocol.derive(Jason.Encoder, ExDoc.ModuleNode,
  only: [
    # :doc, :docs, :nested_context, :id, :rendered_doc, :docs_groups
    # TODO: Missing ones...
    :annotations,
    :deprecated,
    :doc_format,
    :doc_line,
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
    # TODO: Missing ones...
    # :doc, :spec,
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
    # TODO: Missing ones...
    # :doc, :specs,
    :annotations,
    :arity,
    :defaults,
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
