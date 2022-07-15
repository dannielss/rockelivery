defmodule Rockelivery.Order do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:address, :comments, :payment_method, :user_id]
  @payment_methods [:money, :credit_card, :debit_card]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :address, :string
    field :comments, :string
    field :payment_method, Ecto.Enum, values: @payment_methods

    many_to_many :items, Item, join_through: "orders_items"
    belongs_to :user, User

    timestamps()
  end

  def changeset(params, items),
    do: fields_validation(%__MODULE__{}, @required_params, params, items)

  defp fields_validation(struct, fields, params, items) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> put_assoc(:items, items)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)
  end
end
