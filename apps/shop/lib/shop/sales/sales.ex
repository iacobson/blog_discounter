defmodule Shop.Sales do
  import Ecto.{Query, Changeset}, warn: false
  alias Shop.Repo
  alias Shop.Sales.Product

  def list_products do
    top_discounts_query()
    |> Repo.all()
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

  defp top_discounts_query do
    from product in Product,
      select: %{
        id: product.id,
        previous: product.previous,
        actual: product.actual,
        discount: fragment("ROUND((1 - (1.0 * ?) / ?) * 100, 2) as discount", product.actual, product.previous)},
      order_by: [desc: fragment("discount")], limit: 10
  end
end
