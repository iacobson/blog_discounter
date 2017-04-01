defmodule Shop.Cache do
  use GenServer
  alias Shop.Sales

  # API
  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_products_v2 do
    GenServer.call(__MODULE__, :get_products_v2)
  end

  def post_product_v2 do
    GenServer.cast(__MODULE__, :post_product_v2)
  end

  # CALLBACKS
  def init(:ok) do
    {:ok, Sales.list_products()}
  end

  def handle_call(:get_products_v2, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:post_product_v2, _state) do
    {:noreply, Sales.list_products()}
  end
end
