defmodule Shop.MockCache do
  alias Shop.Sales

  def get_products_v2 do
    Sales.list_products()
  end

  def post_product_v2 do
    Sales.list_products()
  end

  def post_product_v3(_product) do
    Sales.list_products()
  end
end
