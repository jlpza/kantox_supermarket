defmodule Discounts.NewPriceForBuyingMoreThan do
  @type t :: %__MODULE__{
          product_id: String.t(),
          minimum_units: float(),
          new_price: float()
        }
  defstruct product_id: nil, minimum_units: 0, new_price: 0.00

  defimpl Discounts.Discount, for: __MODULE__ do
    alias Data.Product
    alias Discounts.NewPriceForBuyingMoreThan

    @spec apply(NewPriceForBuyingMoreThan.t(), list(Product.t())) :: list(Product.t())
    def apply(
          %NewPriceForBuyingMoreThan{
            product_id: product_id,
            minimum_units: minimum_units,
            new_price: new_price
          },
          shopping_cart
        ) do
      {products, other_products} = Enum.split_with(shopping_cart, &(&1.id == product_id))

      if length(products) >= minimum_units do
        Enum.map(products, &%Product{&1 | price: new_price}) ++ other_products
      else
        shopping_cart
      end
    end
  end
end
