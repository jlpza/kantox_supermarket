defmodule Discounts do
  alias Discounts.{
    BuySomeGetSomeFree,
    DiscountForBuyingMoreThan,
    NewPriceForBuyingMoreThan
  }

  def get_discounts() do
    [
      # Green Tea, do one get one free
      %BuySomeGetSomeFree{product_id: "GR1", needed_products: 1, free_products: 1},
      # Strawberries discount if you buy 3 or more
      %NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 3, new_price: 4.50},
      # Coffee discount if you buy 3 or more
      %DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 3, discount_rate: 2 / 3}
    ]
  end
end
