defmodule BuySomeGetSomeTest do
  use ExUnit.Case
  import Mock

  alias Discounts.BuySomeGetSomeFree

  setup_all _ do
    Data.load_products("data/products_test.csv")
  end

  test_with_mock "Buy 3 get 1", Discounts,
    get_discounts: fn ->
      [%BuySomeGetSomeFree{product_id: "GR1", needed_products: 3, free_products: 1}]
    end do
    assert Float.round(3.11, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 1))
    assert Float.round(3.11 * 2, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 2))
    assert Float.round(3.11 * 3, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 3))
    assert Float.round(3.11 * 3, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 4))
    assert Float.round(3.11 * 4, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 5))
    assert Float.round(3.11 * 5, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 6))
    assert Float.round(3.11 * 6, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 7))
    assert Float.round(3.11 * 6, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 8))
    assert Float.round(3.11 * 7, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 9))
  end

  test_with_mock "Buy 1 get 3", Discounts,
    get_discounts: fn ->
      [%BuySomeGetSomeFree{product_id: "GR1", needed_products: 1, free_products: 3}]
    end do
    assert Float.round(3.11, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 1))
    assert Float.round(3.11, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 2))
    assert Float.round(3.11, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 3))
    assert Float.round(3.11, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 4))
    assert Float.round(3.11 * 2, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 5))
    assert Float.round(3.11 * 2, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 6))
    assert Float.round(3.11 * 2, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 7))
    assert Float.round(3.11 * 2, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 8))
    assert Float.round(3.11 * 3, 2) == KantoxSupermarket.calculate_price(List.duplicate("GR1", 9))
  end
end
