# ExDocJson

The `ExDoc.Formatter.JSON` formatter extends [ExDoc][] to generate JSON
documentation for Elixir projects.

## Installation

The package can be installed by adding `ex_doc_json` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_doc_json, "~> 0.1.0", only: [:test, :dev], runtime: false}
  ]
end
```

## Usage

In `mix.exs` add the formatters configuration:

```elixir
def project do
  [
    app: :my_app,
    version: "0.1.0-dev",
    deps: deps(),

    # Docs
    docs: [
      formatters: ["html", "epub", ExDoc.Formatter.JSON]
    ]
  ]
end
```

Or you can usage the following command: `mix docs --formatter json`

Further documentation can be found at <https://hexdocs.pm/ex_doc_json>.

[ExDoc]: https://github.com/elixir-lang/ex_doc
