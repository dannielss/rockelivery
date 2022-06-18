defmodule RockeliveryWeb.WelcomeController do
  use RockeliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Hello World!", users: [%{name: "Daniel"}, %{name: "Pedro"}]})
  end
end
