defmodule KantoxSupermarket do
  @moduledoc """
  Documentation for `KantoxSupermarket`.
  """
  alias Discounts.Discount

  @spec calculate_price(list(String.t())) :: float()
  def calculate_price(basket) do
    products = Enum.map(basket, &Data.get_product/1)

    Discounts.get_discounts()
    |> Enum.reduce(products, &Discount.apply/2)
    |> Enum.reduce(0.00, fn %Data.Product{price: price}, acc -> acc + price end)
    |> Float.round(2)
  end
end
