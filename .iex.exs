# import Ecto.Query

import_if_available(Ecto.Query)
import_if_available(Ecto.Changeset)

import_file("./.app.exs")

# import_file("./.lib.exs")

# File.read!("./.lib.exs")
# |> Code.compile_string()
# |> IO.inspect()

# IO.inspect(__MODULE__)

# alias :erlang, as: Erlang
# import Erlang, only: [halt: 0]

# import :erlang, only: [halt: 0]

alias App.PgRepo
alias App.Ecto.Tour01.Hub.{User, Link, Tag, Pin, UserTag, PinTag}

defmodule IExHelper do
  def what?(term) when is_nil(term), do: "Type: Nil"
  def what?(term) when is_binary(term), do: "Type: Binary"
  def what?(term) when is_boolean(term), do: "Type: Boolean"
  def what?(term) when is_atom(term), do: "Type: Atom"
  def what?(_term), do: "Type: Unknown"
end

defmodule AC do
  def config(), do: IEx.configuration()

  def exe() do
    File.read!("./.lib.exs")
    |> Code.compile_string()
    |> IO.inspect()

    # import IEx.Lib
  end

  def update(schema, changes) do
    schema
    |> Ecto.Changeset.change(changes)
    |> Repo.update()
  end

  IEx.configure(
    colors: [
      syntax_colors: [
        number: :light_yellow,
        atom: :light_cyan,
        string: :light_black,
        boolean: [:light_blue],
        nil: [:magenta, :bright]
      ],
      ls_directory: :cyan,
      ls_device: :yellow,
      doc_code: :green,
      doc_inline_code: :magenta,
      doc_headings: [:cyan, :underline],
      doc_title: [:cyan, :bright, :underline]
    ],
    default_prompt:
      [
        "\e[G",
        :light_magenta,
        "🧪",
        ":",
        :reset,
        :cyan,
        "%counter",
        :reset,
        ">",
        :white,
        :reset
      ]
      |> IO.ANSI.format()
      |> IO.chardata_to_string()
  )
end

# def add(x), do: x + 3
