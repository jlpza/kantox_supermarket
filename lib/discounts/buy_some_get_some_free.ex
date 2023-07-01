defmodule Discounts.BuySomeGetSomeFree do
  @type t :: %__MODULE__{
          product_id: String.t(),
          needed_products: non_neg_integer(),
          free_products: non_neg_integer()
        }
  defstruct product_id: nil, needed_products: 0, free_products: 0

  defimpl Discounts.Discount, for: __MODULE__ do
    alias Data.Product
    alias Discounts.BuySomeGetSomeFree

    @spec apply(BuySomeGetSomeFree.t(), list(Product.t())) :: list(Product.t())
    def apply(
          %BuySomeGetSomeFree{
            product_id: product_id,
            needed_products: needed_products,
            free_products: free_products
          },
          shopping_cart
        ) do
      {products, other_products} = Enum.split_with(shopping_cart, &(&1.id == product_id))

      products
      # Split 'products' into batches of 'needed_products + free_products' size.
      |> Enum.chunk_every(needed_products + free_products)
      |> Enum.flat_map(fn product_batch ->
        # The first 'needed_products' products will be paid, while the remaining 'free_products' products will be free.
        {paid_products, free_products} = Enum.split(product_batch, needed_products)
        paid_products ++ Enum.map(free_products, &%Product{&1 | price: 0.00})
      end)
      |> Kernel.++(other_products)
    end
  end
end
