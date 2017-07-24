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

  def post_product_v3(product) do
    GenServer.call(__MODULE__, {:post_product_v3, product})
  end

  # CALLBACKS
  def init(:ok) do
    {:ok, Sales.list_products()}
  end

  def handle_call(:get_products_v2, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:post_product_v3, new_product}, _from, state) do
    new_discount = discount(new_product)
    last_discount = List.last(state)[:discount]
    state = new_state(new_discount, last_discount, new_product, state)

    {:reply, state, state}
  end

  def handle_cast(:post_product_v2, _state) do
    {:noreply, Sales.list_products()}
  end

  # HELPERS
  defp discount(product) do
    (1.0 - (product.actual / product.previous)) * 100
    |> Decimal.new()
    |> Decimal.round(2)
  end

  defp new_state(new_discount, last_discount, new_product, state)
    when new_discount > last_discount do

    state
    |> List.delete_at(-1)
    |> List.insert_at(-1, formatted(new_product, new_discount))
    |> Enum.sort(&(&1.discount > &2.discount))
  end

  defp new_state(_new_discount, _last_discount, _new_product, state), do: state

  def formatted(new_product, new_discount) do
    %{
      id: new_product.id,
      previous: new_product.previous,
      actual: new_product.actual,
      discount: new_discount
    }
  end
end
