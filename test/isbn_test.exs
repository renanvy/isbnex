defmodule ISBNTest do
  use ExUnit.Case, async: true
  doctest ISBN
  alias ISBN

  describe "valid?/1 " do
    test "returns truthy when ISBN is valid" do
      # ISBN10
      assert ISBN.valid?("9971502100")
      assert ISBN.valid?("99921-58-10-7")
      assert ISBN.valid?("960 425 059 0")
      assert ISBN.valid?("0-9752298-0-X")
      assert ISBN.valid?("    0-9752298-0-X    ")

      # ISBN13
      assert ISBN.valid?("9780306406157")
      assert ISBN.valid?("9783161484100")
      assert ISBN.valid?("978-0-306-40615-7")
      assert ISBN.valid?("978 0 306 40615 7")
      assert ISBN.valid?("   978 0 306 40615 7   ")
    end

    test "returns falsy when ISBN is invalid" do
      refute ISBN.valid?("99")
      refute ISBN.valid?(9)

      # ISBN10
      refute ISBN.valid?("9971502101")
      refute ISBN.valid?("9971502101234234233")
      refute ISBN.valid?("99921-58-10-6")

      # ISBN13
      refute ISBN.valid?("9780306406156")
      refute ISBN.valid?("9971502100234234233")
      refute ISBN.valid?("978-0-306-40615-6")
    end
  end

  describe "format/1" do
    test "returns ISBN formatted when is valid" do
      # ISBN10
      assert ISBN.format("9992158107") == "99-9215-810-7"
      assert ISBN.format("99-9215-810-7") == "99-9215-810-7"

      # ISBN13
      assert ISBN.format("9780306406157") == "978-03-0640-615-7"
      assert ISBN.format("978-03-0640-615-7") == "978-03-0640-615-7"
    end

    test "returns nil when ISBN is invalid" do
      assert ISBN.format("9") == nil

      # ISBN10
      assert ISBN.format("9992158106") == nil

      # ISBN13
      assert ISBN.format("9780306406156") == nil
    end

    test "returns nil when ISBN is not an string" do
      assert ISBN.format(9_992_158_107) == nil
    end
  end
end
