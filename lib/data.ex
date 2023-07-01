defmodule Data do
  @products_file "data/products.csv"

  defmodule Product do
    @type t :: %__MODULE__{
            id: String.t(),
            name: String.t(),
            price: float()
          }
    defstruct id: nil, name: nil, price: 0.0
  end

  @spec load_products(products_file :: String.t()) :: :ok
  def load_products(products_file \\ @products_file) do
    :ets.new(:product, [:set, :protected, :named_table])

    products_file
    |> File.stream!()
    |> CSV.decode!()
    |> Enum.map(fn [id, name, price] ->
      %Product{id: id, name: name, price: String.to_float(price)}
    end)
    |> Enum.each(fn %Product{id: id} = product -> :ets.insert(:product, {id, product}) end)

    :ok
  end

  @spec get_product(product_id :: String.t()) :: Product.t()
  def get_product(product_id) do
    [{^product_id, product}] = :ets.lookup(:product, product_id)
    product
  end
end
