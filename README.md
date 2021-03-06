# ISBN

A library to work with ISBN written in Elixir.

[![Hex pm](https://img.shields.io/hexpm/v/isbnex.svg?style=flat)](https://www.hex.pm/packages/isbnex)
[![Hex pm](https://img.shields.io/hexpm/l/isbnex)](https://github.com/renanvy/isbnex/blob/master/LICENSE)
[![Elixir CI](https://github.com/renanvy/isbnex/workflows/build/badge.svg?branch=master)](https://github.com/renanvy/isbnex/workflows/build/badge.svg?branch=master)
[![Coverage Status](https://coveralls.io/repos/github/renanvy/isbnex/badge.svg?branch=master)](https://coveralls.io/github/renanvy/isbnex?branch=master)

The International Standard Book Number (ISBN) is a numeric commercial book identifier which is intended to be unique. Publishers purchase ISBNs from an affiliate of the International ISBN Agency.

An ISBN is assigned to each separate edition and variation (except reprintings) of a publication. For example, an e-book, a paperback and a hardcover edition of the same book will each have a different ISBN. The ISBN is ten digits long if assigned before 2007, and thirteen digits long if assigned on or after 1 January 2007. The method of assigning an ISBN is nation-specific and varies between countries, often depending on how large the publishing industry is within a country. Reference [here](https://en.wikipedia.org/wiki/International_Standard_Book_Number)

This library provides a validation that checks if the ISBN is valid and a formatter.
The ISBN has check digit algorithm, you can check the details [here](https://en.wikipedia.org/wiki/International_Standard_Book_Number).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `isbnex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:isbnex, "~> 0.2.0"}
  ]
end
```

## Quick Start

You can verify if a ISBN is valid by calling the function `ISBN.valid?/1`. Works with both ISBN-10 and ISBN-13. Allows hyphens and spaces in the string.

```elixir
iex> ISBN.valid?("9971502100")
true

iex> ISBN.valid?("99-9215-810-7")
true

iex> ISBN.valid?("978-0-306-40615-7")
true

iex> ISBN.valid?("978 0 306 40615 7")
true

iex> ISBN.valid?("0-9752298-0-X")
true

iex> ISBN.valid?("978-0-306-40615-6")
false
```

The `ISBN.format/1` returns ISBN wrapped.

```elixir
iex> ISBN.format("9780306406157")
"978-03-0640-615-7"

iex> ISBN.format("9992158107")
"99-9215-810-7"

iex> ISBN.format("111111")
nil
```

## Validation with Changeset

You can use `ISBN.Ecto.Changeset.validate_isbn/3` function to validate a field in your changeset. Example:

```elixir
defmodule MyApp.Libraries.Book do
  @moduledoc """
  The Book schema.
  """

  use Ecto.Schema
  import Ecto.Changeset

  # Import this module
  import ISBN.Ecto.Changeset

  schema "books" do
    field :isbn, :string, null: false
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn])
    |> validate_isbn([:isbn])
  end
end

iex> changeset = MyApp.Libraries.Book.changeset(%MyApp.Libraries.Book{}, %{isbn: "12345567"})
iex> {:error, %Ecto.Changeset{}} = Repo.insert(changeset)
iex> changeset
#Ecto.Changeset<action: :insert, changes: %{isbn: "1234567890"}, errors: [isbn: {"is invalid", []}], data: #MyApp.Libraries.Book<>, valid?: false>
```

## Docs

The docs can be found at [https://hexdocs.pm/isbnex](https://hexdocs.pm/isbnex).

## Contribute

Feel free to contribute to this project. If you have any suggestions or bug reports just open an issue or a PR.
