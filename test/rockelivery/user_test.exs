defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "should returns a valid changeset, when all params are valid" do
      params = %{
        age: 21,
        address: "Rua X",
        cep: "07133310",
        cpf: "32511652415",
        email: "daniel@hotmail.com",
        password: "123456",
        name: "Daniel"
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Daniel"}, valid?: true} = response
    end

    test "should returns a valid changeset with the given changes, when updating a changeset" do
      params = %{
        age: 21,
        address: "Rua X",
        cep: "07133310",
        cpf: "32511652415",
        email: "daniel@hotmail.com",
        password: "123456",
        name: "Daniel"
      }

      update_params = %{name: "Daniel de Sousa"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Daniel de Sousa"}, valid?: true} = response
    end

    test "should returns an invalid changeset, when there are some error" do
      params = %{
        age: 15,
        address: "Rua X",
        cep: "07133310",
        cpf: "32511652415",
        email: "daniel@hotmail.com",
        password: "123",
        name: "Daniel"
      }

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
