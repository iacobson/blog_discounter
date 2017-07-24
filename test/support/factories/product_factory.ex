defmodule Shop.Sales.ProductFactory do
  use ExMachina.Ecto, repo: Shop.Repo
  alias Shop.Sales.Product

  def product_factory do
    previous = Enum.random(10..1000)
    actual = round(previous * (Enum.random(20 ..90) / 100))
    %Product{
      actual: actual,
      previous: previous
    }
  end
end
