defmodule Rockelivery.ItemTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.Item

  describe "changeset/2" do
    test "should returns a valid changeset, when all params are valid" do
      params = build(:item_params)

      response = Item.changeset(params)

      assert %Changeset{changes: %{description: "suco de laranja"}, valid?: true} = response
    end

    test "should returns an invalid changeset, when there are some error" do
      params = build(:item_params, %{price: "-1"})

      response = Item.changeset(params)

      expected_response = %{price: ["must be greater than 0"]}

      assert errors_on(response) == expected_response
    end
  end
end
