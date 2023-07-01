defmodule DiscountForBuyingMoreThanTest do
  use ExUnit.Case
  import Mock

  alias Discounts.DiscountForBuyingMoreThan

  setup_all _ do
    Data.load_products("data/products_test.csv")
  end

  test_with_mock "Buy 3 or more, 30% discount", Discounts,
    get_discounts: fn ->
      [%DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 3, discount_rate: 0.7}]
    end do
    assert Float.round(11.23, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 1))

    assert Float.round(11.23 * 2, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 2))

    assert Float.round(11.23 * 3 * 0.7, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 3))

    assert Float.round(11.23 * 4 * 0.7, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 4))

    assert Float.round(11.23 * 5 * 0.7, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 5))

    assert Float.round(11.23 * 6 * 0.7, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 6))

    assert Float.round(11.23 * 7 * 0.7, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 7))
  end

  test_with_mock "Buy 1 or more, 20% discount", Discounts,
    get_discounts: fn ->
      [%DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 1, discount_rate: 0.8}]
    end do
    assert Float.round(11.23 * 0.8, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 1))

    assert Float.round(11.23 * 2 * 0.8, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 2))

    assert Float.round(11.23 * 3 * 0.8, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 3))

    assert Float.round(11.23 * 4 * 0.8, 2) ==
             KantoxSupermarket.calculate_price(List.duplicate("CF1", 4))
  end
end
