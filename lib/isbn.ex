defmodule ISBN do
  @moduledoc """
  Documentation for ISBN.
  """

  @isbn13_multipliers [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]
  @isbn10_multipliers [1, 2, 3, 4, 5, 6, 7, 8, 9]

  @doc """
  Checks if the given string is a valid ISBN.

  Works with both ISBN-10 and ISBN-13. Allows hyphens and spaces in the string.

  ## Examples

      iex> ISBN.valid?("9971502100")
      true

      iex> ISBN.valid?("978-03-0640-615-7")
      true

  """

  def valid?(isbn) when is_binary(isbn) do
    last_digit = isbn |> String.trim() |> String.last()

    digits =
      isbn
      |> remove_spaces_and_dashes()
      |> String.slice(0..-2)
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)

    reveal_verifier(digits) == last_digit
  end

  def valid?(_), do: false

  @doc """
  Returns ISBN formatted.

  ## Examples

      iex> ISBN.format("9992158107")
      "99-9215-810-7"

      iex> ISBN.format("9992158106")
      nil

  """
  def format(isbn) when not is_binary(isbn), do: nil

  def format(isbn) do
    case valid?(isbn) do
      true ->
        isbn
        |> remove_spaces_and_dashes()
        |> String.codepoints()
        |> do_format()

      _ ->
        nil
    end
  end

  defp do_format(digits) when length(digits) == 10 do
    digits
    |> List.insert_at(2, "-")
    |> List.insert_at(7, "-")
    |> List.insert_at(11, "-")
    |> Enum.join()
  end

  defp do_format(digits) when length(digits) == 13 do
    digits
    |> List.insert_at(3, "-")
    |> List.insert_at(6, "-")
    |> List.insert_at(11, "-")
    |> List.insert_at(15, "-")
    |> Enum.join()
  end

  defp do_format(_isbn), do: nil

  defp reveal_verifier(digits) when length(digits) == 9 do
    acc = calculate(digits, @isbn10_multipliers)
    rem = rem(acc, 11)
    if rem == 10, do: "X", else: Integer.to_string(rem)
  end

  defp reveal_verifier(digits) when length(digits) == 12 do
    acc = calculate(digits, @isbn13_multipliers)
    rem = rem(acc, 10)
    if rem == 0, do: "0", else: Integer.to_string(10 - rem)
  end

  defp reveal_verifier(_isbn), do: nil

  defp calculate(digits, multipliers) do
    multipliers
    |> Enum.zip(digits)
    |> Enum.reduce(0, fn {multiplier, digit}, acc ->
      acc + multiplier * digit
    end)
  end

  defp remove_spaces_and_dashes(isbn) do
    isbn
    |> String.trim()
    |> String.replace("-", "")
    |> String.replace(" ", "")
  end
end
