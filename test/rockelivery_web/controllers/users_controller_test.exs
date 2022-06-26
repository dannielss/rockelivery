defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  describe "create/2" do
    test "it should creates a user, when all params are valid", %{conn: conn} do
      params = %{
        "age" => 21,
        "address" => "Rua X",
        "cep" => "07133310",
        "cpf" => "32511652415",
        "email" => "daniel@hotmail.com",
        "password" => "123456",
        "name" => "Daniel"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{"message" => "User created!", "user" => %{"id" => _id, "name" => "Daniel"}} =
               response
    end

    test "it should returns an error, when there is any invalid params", %{conn: conn} do
      params = %{
        "age" => 15,
        "address" => "Rua X",
        "cep" => "07133310",
        "cpf" => "32511652415",
        "email" => "daniel@hotmail.com",
        "password" => "123",
        "name" => "Daniel"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "age" => ["must be greater than or equal to 18"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } = response
    end
  end
end
