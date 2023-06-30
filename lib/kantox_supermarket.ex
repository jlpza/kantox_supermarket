defmodule KantoxSupermarket do
  @moduledoc """
  Documentation for `KantoxSupermarket`.
  """
  alias Discounts.{
    BuySomeGetSomeFree,
    Discount,
    DiscountForBuyingMoreThan,
    NewPriceForBuyingMoreThan
  }

  def calculate_price(basket) do
    products = Enum.map(basket, &Data.get_product/1)

    [
      # Green Tea, do one get one free
      %BuySomeGetSomeFree{product_id: "GR1", needed_products: 1, free_products: 1},
      # Strawberries discount if you buy 3 or more
      %NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 3, new_price: 4.50},
      # Coffee discount if you buy 3 or more
      %DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 3, discount_rate: 2 / 3}
    ]
    |> Enum.reduce(products, &Discount.apply/2)
    |> Enum.reduce(0.00, fn %Data.Product{price: price}, acc -> acc + price end)
    |> Float.round(2)
  end
end
