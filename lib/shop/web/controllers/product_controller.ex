defmodule Shop.Web.ProductController do
  use Shop.Web, :controller

  alias Shop.{Sales, Sales.Product, Cache}

  action_fallback Shop.Web.FallbackController

  def get_discounts(conn, %{"version" => "v1"}) do
    products = Sales.list_products()
    render(conn, "index.json", products: products)
  end

  def get_discounts(conn, %{"version" => "v2"}) do
    products = Cache.get_products_v2()
    render(conn, "index.json", products: products)
  end

  def new_product(conn, %{"version" => "v1"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end

  def new_product(conn, %{"version" => "v2"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      Cache.post_product_v2()
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end

  def new_product(conn, %{"version" => "v3"}) do
    with {:ok, %Product{} = product} <- Sales.create_product() do
      Cache.post_product_v3(product)
      conn
      |> put_status(:created)
      |> render("show.json", product: product)
    end
  end
end
