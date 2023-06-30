defmodule Discounts.BuySomeGetSomeFree do
  defstruct product_id: nil, needed_products: 0, free_products: 0

  defimpl Discounts.Discount, for: __MODULE__ do
    alias Data.Product

    def apply(
          %Discounts.BuySomeGetSomeFree{
            product_id: product_id,
            needed_products: needed_products,
            free_products: free_products
          },
          shopping_cart
        ) do
      {products, other_products} = Enum.split_with(shopping_cart, &(&1.id == product_id))

      products
      |> Enum.chunk_every(needed_products + free_products)
      |> Enum.flat_map(fn products ->
        {paid_products, free_products} = Enum.split(products, needed_products)
        paid_products ++ Enum.map(free_products, &%Product{&1 | price: 0.00})
      end)
      |> Kernel.++(other_products)
    end
  end
end
