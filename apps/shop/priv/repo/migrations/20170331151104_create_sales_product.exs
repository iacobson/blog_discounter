defmodule Shop.Repo.Migrations.CreateShop.Sales.Product do
  use Ecto.Migration

  def change do
    create table(:sales_products) do
      add :previous, :integer
      add :actual, :integer

      timestamps()
    end

  end
end
