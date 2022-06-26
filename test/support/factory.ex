defmodule Rockelivery.Factory do
  use ExMachina

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
end
