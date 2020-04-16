# ISBN

A library to work with ISBN written in Elixir.

[![Hex pm](https://img.shields.io/hexpm/v/isbnex.svg?style=flat)](https://www.hex.pm/packages/isbnex)
[![Elixir CI](https://github.com/renanvy/isbnex/workflows/Elixir%20CI/badge.svg?branch=master)](https://github.com/renanvy/isbnex/actions?query=workflow%3A%22Elixir+CI%22)
[![Coverage Status](https://coveralls.io/repos/github/renanvy/isbnex/badge.svg?branch=master)](https://coveralls.io/github/renanvy/isbnex?branch=master)

The International Standard Book Number (ISBN) is a numeric commercial book identifier which is intended to be unique. Publishers purchase ISBNs from an affiliate of the International ISBN Agency.

An ISBN is assigned to each separate edition and variation (except reprintings) of a publication. For example, an e-book, a paperback and a hardcover edition of the same book will each have a different ISBN. The ISBN is ten digits long if assigned before 2007, and thirteen digits long if assigned on or after 1 January 2007. The method of assigning an ISBN is nation-specific and varies between countries, often depending on how large the publishing industry is within a country. Reference [here](https://en.wikipedia.org/wiki/International_Standard_Book_Number)

This library provides a validation that checks if the ISBN is valid and a formatter.
The ISBN has check digit algorithm, you can check the details [here](https://en.wikipedia.org/wiki/International_Standard_Book_Number).

## Docs

The docs can be found at [https://hexdocs.pm/isbnex](https://hexdocs.pm/isbnex).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `isbnex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:isbnex, "~> 0.1.0"}
  ]
end
```

## Quick Start

You can verify if a ISBN is valid by calling the function `ISBN.valid?/1`:

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

