defmodule ISBN do
  @moduledoc """
  Documentation for ISBN.
  """

  @isbn13_multipliers [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]
  @isbn10_multipliers [1, 2, 3, 4, 5, 6, 7, 8, 9]

  @doc """
  Checks if ISBN is valid.

  ## Examples

      iex> ISBN.valid?("9971502100")
      true

  """
  def valid?(isbn) when not is_binary(isbn), do: false
  def valid?(isbn) do
    last_digit = isbn |> String.trim() |> String.last()

    digits =
      isbn
      |> String.replace("-", "")
      |> String.replace(" ", "")
      |> String.slice(0..-2)
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)

    reveal_verifier(digits) == last_digit
  end

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
end
