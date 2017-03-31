defmodule Shop.Web.ProductController do
  use Shop.Web, :controller

  alias Shop.Sales
  alias Shop.Sales.Product

  action_fallback Shop.Web.FallbackController

  def index(conn, _params) do
    products = Sales.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Sales.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end
end
