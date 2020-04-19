if Code.ensure_loaded?(Ecto.Changeset) do
  defmodule ISBN.Ecto.Changeset do
    @moduledoc """
    Provide function to validate ISBN field in a changeset
    """

    @doc """
    Verifies if given `field` in the `changeset` has a valid ISBN.

    ## Examples

        iex> {%{}, %{isbn: :string}}
        ...> |> Ecto.Changeset.cast(%{isbn: "978-03-0640-615-7"}, [:isbn])
        ...> |> ISBN.Ecto.Changeset.validate_isbn(:isbn)
        #Ecto.Changeset<action: nil, changes: %{isbn: "978-03-0640-615-7"}, errors: [], data: %{}, valid?: true>

        iex> {%{}, %{isbn: :string}}
        ...> |> Ecto.Changeset.cast(%{isbn: "1234567890"}, [:isbn])
        ...> |> ISBN.Ecto.Changeset.validate_isbn(:isbn)
        #Ecto.Changeset<action: nil, changes: %{isbn: "1234567890"}, errors: [isbn: {"is invalid", []}], data: %{}, valid?: false>
    """
    def validate_isbn(changeset, field, options \\ []) do
      Ecto.Changeset.validate_change(changeset, field, fn _, value ->
        case ISBN.valid?(value) do
          true ->
            []

          _ ->
            [{field, {options[:message] || "is invalid", []}}]
        end
      end)
    end
  end
end
