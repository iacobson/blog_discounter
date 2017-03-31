defmodule Shop.Sales do
  import Ecto.{Query, Changeset}, warn: false
  alias Shop.Repo
  alias Shop.Sales.Product

  def list_products do
    Repo.all(Product)
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> product_changeset(attrs)
    |> Repo.insert()
  end

  defp product_changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:previous, :actual])
    |> validate_required([:previous, :actual])
  end
end
