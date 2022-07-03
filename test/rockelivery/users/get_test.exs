defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, User}
  alias Rockelivery.Users.{Create, Get}

  describe "call/1" do
    test "it should returns the user when all params are valid" do
      params = build(:user_params)

      {:ok, %User{id: id}} = Create.call(params)

      response = Get.by_id(id)

      assert {:ok, %User{id: _id, name: "Daniel"}} = response
    end

    test "it should returns an error, when user not found" do
      response = Get.by_id("95b9d1d4-b59a-4a78-b784-d74fad887e26")

      assert {:error, %Error{result: "User not found", status: :not_found}} = response
    end
  end
end
