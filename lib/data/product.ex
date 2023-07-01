defmodule Data.Product do
  @products_file "data/products.csv"

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          price: float()
        }
  defstruct id: nil, name: nil, price: 0.0

  @spec load(products_file :: String.t()) :: :ok
  def load(products_file \\ @products_file) do
    :ets.new(:product, [:set, :protected, :named_table])

    products_file
    |> File.stream!()
    |> CSV.decode!()
    |> Enum.map(fn [id, name, price] ->
      %__MODULE__{id: id, name: name, price: String.to_float(price)}
    end)
    |> Enum.each(fn %__MODULE__{id: id} = product -> :ets.insert(:product, {id, product}) end)

    :ok
  end

  @spec get(product_id :: String.t()) :: {:ok, t()} | {:error, String.t()}
  def get(product_id) do
    case :ets.lookup(:product, product_id) do
      [{^product_id, product}] -> {:ok, product}
      _ -> {:error, "Product id #{inspect(product_id)} not recognized"}
    end
  end
end
