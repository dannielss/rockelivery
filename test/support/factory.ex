defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 21,
      address: "Rua X",
      cep: "07133310",
      cpf: "32511652415",
      email: "daniel@hotmail.com",
      password: "123456",
      name: "Daniel"
    }
  end

  def item_params_factory do
    %{
      category: :drink,
      description: "suco de laranja",
      price: "15.00",
      photo: "/priv/photos/random.jpg"
    }
  end

  def user_factory do
    %User{
      age: 21,
      address: "Rua X",
      cep: "07133310",
      cpf: "32511652415",
      email: "daniel@hotmail.com",
      password: "123456",
      name: "Daniel",
      id: "95b9d1d4-b59a-4a78-b784-d74fad887e26"
    }
  end
end
