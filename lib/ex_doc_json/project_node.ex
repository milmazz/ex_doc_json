require Protocol

Protocol.derive(Jason.Encoder, ExDoc.ModuleNode,
  only: [
    :module,
    # :doc,
    :doc_line,
    :source_path,
    :source_url,
    :title,
    :type,
    :typespecs,
    :annotations
  ]
)

Protocol.derive(Jason.Encoder, ExDoc.TypeNode,
  only: [
    :name,
    :arity,
    :type,
    :deprecated,
    # :doc,
    :source_doc,
    :rendered_doc,
    :doc_line,
    :source_path,
    :source_url,
    # :spec,
    :signature,
    :annotations
  ]
)

Protocol.derive(Jason.Encoder, ExDoc.FunctionNode,
  only: [
    :name,
    :arity,
    :defaults,
    :deprecated,
    # :doc,
    :source_doc,
    :rendered_doc,
    :type,
    :signature,
    # :specs,
    :annotations,
    :group,
    :doc_line,
    :source_path,
    :source_url
  ]
)

defmodule ExDocJSON.ProjectNode do
  @moduledoc """
  Structure that represents a *project*
  """

  @derive [Jason.Encoder]
  defstruct [
    :name,
    :version,
    :homepage_url,
    :description,
    :icon,
    :language,
    :items,
    :attachments,
    :extras,
    about: "ExDoc/version/1"
  ]

  @type t :: %__MODULE__{
          about: String.t(),
          name: String.t(),
          version: String.t(),
          homepage_url: String.t(),
          description: String.t(),
          icon: String.t(),
          language: String.t(),
          items: map
        }
end
