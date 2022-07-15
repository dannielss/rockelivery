defmodule Rockelivery.Item do
  use Ecto.Schema
  import Ecto.Changeset

  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]
  @items_categories [:food, :drink, :desert]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "items" do
    field :category, Ecto.Enum, values: @items_categories
    field :description, :string
    field :price, :decimal
    field :photo, :string

    many_to_many :orders, Order, join_through: "orders_items"

    timestamps()
  end

  def changeset(params), do: fields_validation(%__MODULE__{}, @required_params, params)

  defp fields_validation(struct, fields, params) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
