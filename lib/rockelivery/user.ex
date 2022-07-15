defmodule Rockelivery.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:age, :address, :cep, :cpf, :email, :password, :name]
  @update_params [:age, :address, :cep, :cpf, :email, :name]

  @derive {Jason.Encoder, only: [:id, :age, :cpf, :address, :email, :name]}

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    has_many :orders, Order

    timestamps()
  end

  def changeset(params), do: fields_validation(%__MODULE__{}, @required_params, params)

  def changeset(struct, params), do: fields_validation(struct, @update_params, params)

  defp fields_validation(struct, fields, params) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:password, min: 6)
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
