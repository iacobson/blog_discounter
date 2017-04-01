defmodule Shop.Sales.Product do
  use Ecto.Schema

  schema "sales_products" do
    field :actual, :integer
    field :previous, :integer

    timestamps()
  end
end
