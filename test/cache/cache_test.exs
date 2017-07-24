defmodule Shop.CacheTest do
  use Shop.DataCase
  alias Shop.Cache
  alias Shop.Sales.ProductFactory

  setup do
    for actual <- (700 .. 730) do
      ProductFactory.insert(:product, previous: 900, actual: actual)
    end
    Supervisor.terminate_child(Shop.Supervisor, Cache)
    Supervisor.restart_child(Shop.Supervisor, Cache)

    :ok
  end

  test "can get top discounts" do
    top = Cache.get_products_v2()

    assert Enum.count(top) == 10
    assert List.first(top).actual == 700
    assert List.last(top).actual == 709
  end

  test "can insert new products" do
    product = ProductFactory.insert(:product, previous: 900, actual: 600)
    Cache.post_product_v3(product)

    top = Cache.get_products_v2()
    assert Enum.count(top) == 10
    assert Enum.at(top, 0).actual == 600
    assert Enum.at(top, 1).actual == 700
  end
end
