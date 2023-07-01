defmodule Data do
  @products_file "data/products.csv"

  defmodule Product do
    defstruct id: nil, name: nil, price: 0.0
  end

  def load_products(products_file \\ @products_file) do
    :ets.new(:product, [:set, :protected, :named_table])

    products_file
    |> File.stream!()
    |> CSV.decode!()
    |> Enum.map(fn [id, name, price] ->
      %Product{id: id, name: name, price: String.to_float(price)}
    end)
    |> Enum.each(fn %Product{id: id} = product -> :ets.insert(:product, {id, product}) end)
  end

  def get_product(product_id) do
    [{^product_id, product}] = :ets.lookup(:product, product_id)
    product
  end
end
