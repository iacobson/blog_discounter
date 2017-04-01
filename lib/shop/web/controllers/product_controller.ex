defmodule Shop.Web.ProductController do
  use Shop.Web, :controller

  alias Shop.{Sales, Sales.Product, Cache}

  action_fallback Shop.Web.FallbackController

  def index(conn, %{"version" => "v1"}) do
    products = Sales.list_products()
    render(conn, "index.json", products: products)
  end

  def index(conn, %{"version" => "v2"}) do
    products = Cache.get_products_v2()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"version" => "v1"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end

  def create(conn, %{"version" => "v2"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      Cache.post_product_v2()
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end

  def create(conn, %{"version" => "v3"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      Cache.post_product_v3(product)
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end
end
