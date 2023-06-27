defmodule KantoxSupermarket do
  @moduledoc """
  Documentation for `KantoxSupermarket`.
  """

  def calculate_price(basket) do
    basket_frequencies = Enum.frequencies(basket)
    gr1 = Map.get(basket_frequencies, "GR1", 0)
    sr1 = Map.get(basket_frequencies, "SR1", 0)
    cf1 = Map.get(basket_frequencies, "CF1", 0)

    # Green Tea, do one get one free
    gr1_price = (gr1 - div(gr1, 2)) * 3.11
    # Strawberries discount if you buy 3 or more
    sr1_price = if sr1 >= 3, do: sr1 * 4.50, else: sr1 * 5.00
    # Coffee discount if you buy 3 or more
    cf1_price = if cf1 >= 3, do: cf1 * 11.23 * (2 / 3), else: cf1 * 11.23

    Float.ceil(gr1_price + sr1_price + cf1_price, 2)
  end
end
