defmodule Discounts.DiscountForBuyingMoreThan do
  defstruct product_id: nil, minimum_units: 0, discount_rate: 0.0

  defimpl Discounts.Discount, for: __MODULE__ do
    alias Data.Product

    def apply(
          %Discounts.DiscountForBuyingMoreThan{
            product_id: product_id,
            minimum_units: minimum_units,
            discount_rate: discount_rate
          },
          shopping_cart
        ) do
      {products, other_products} = Enum.split_with(shopping_cart, &(&1.id == product_id))

      if length(products) >= minimum_units do
        Enum.map(products, &%Product{&1 | price: &1.price * discount_rate}) ++ other_products
      else
        shopping_cart
      end
    end
  end
end
