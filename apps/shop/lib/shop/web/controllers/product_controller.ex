defmodule Shop.Web.ProductController do
  use Shop.Web, :controller

  alias Shop.Sales
  alias Shop.Sales.Product

  action_fallback Shop.Web.FallbackController

  def index(conn, %{"version" => "v1"}) do
    products = Sales.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"version" => "v1"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end
end
