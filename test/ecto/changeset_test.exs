defmodule ISBN.Ecto.ChangesetTest do
  use ExUnit.Case, async: true

  doctest ISBN.Ecto.Changeset

  import ISBN.Ecto.Changeset

  describe "validate_isbn/2" do
    test "returns error with default message when ISBN is invalid" do
      assert [{:isbn, {"is invalid", []}}] ==
               {%{}, %{isbn: :string}}
               |> Ecto.Changeset.cast(%{"isbn" => "1234567890"}, [:isbn])
               |> validate_isbn(:isbn)
               |> Map.get(:errors)
    end

    test "returns error with custom message when ISBN is invalid" do
      assert [{:isbn, {"isbn is invalid", []}}] ==
               {%{}, %{isbn: :string}}
               |> Ecto.Changeset.cast(%{"isbn" => "1234567890"}, [:isbn])
               |> validate_isbn(:isbn, message: "isbn is invalid")
               |> Map.get(:errors)
    end

    test "non adds error to valid isbn field" do
      assert [] ==
               {%{}, %{isbn: :string}}
               |> Ecto.Changeset.cast(%{"isbn" => "978-03-0640-615-7"}, [:isbn])
               |> validate_isbn(:isbn)
               |> Map.get(:errors)
    end
  end
end
