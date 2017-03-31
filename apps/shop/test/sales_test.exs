defmodule Shop.SalesTest do
  use Shop.DataCase

  alias Shop.Sales
  alias Shop.Sales.Product

  @create_attrs %{actual: 42, previous: 42}
  @update_attrs %{actual: 43, previous: 43}
  @invalid_attrs %{actual: nil, previous: nil}

  def fixture(:product, attrs \\ @create_attrs) do
    {:ok, product} = Sales.create_product(attrs)
    product
  end

  test "list_products/1 returns all products" do
    product = fixture(:product)
    assert Sales.list_products() == [product]
  end

  test "get_product! returns the product with given id" do
    product = fixture(:product)
    assert Sales.get_product!(product.id) == product
  end

  test "create_product/1 with valid data creates a product" do
    assert {:ok, %Product{} = product} = Sales.create_product(@create_attrs)
    assert product.actual == 42
    assert product.previous == 42
  end

  test "create_product/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Sales.create_product(@invalid_attrs)
  end

  test "update_product/2 with valid data updates the product" do
    product = fixture(:product)
    assert {:ok, product} = Sales.update_product(product, @update_attrs)
    assert %Product{} = product
    assert product.actual == 43
    assert product.previous == 43
  end

  test "update_product/2 with invalid data returns error changeset" do
    product = fixture(:product)
    assert {:error, %Ecto.Changeset{}} = Sales.update_product(product, @invalid_attrs)
    assert product == Sales.get_product!(product.id)
  end

  test "delete_product/1 deletes the product" do
    product = fixture(:product)
    assert {:ok, %Product{}} = Sales.delete_product(product)
    assert_raise Ecto.NoResultsError, fn -> Sales.get_product!(product.id) end
  end

  test "change_product/1 returns a product changeset" do
    product = fixture(:product)
    assert %Ecto.Changeset{} = Sales.change_product(product)
  end
end
