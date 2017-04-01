defmodule Shop.Web.ProductView do
  use Shop.Web, :view
  alias Shop.Web.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      previous: product.previous,
      actual: product.actual,
      discount: product.discount}
  end
end
