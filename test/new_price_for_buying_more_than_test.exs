defmodule NewPriceForBuyingMoreThanTest do
  use ExUnit.Case
  import Mock

  alias Discounts.NewPriceForBuyingMoreThan

  setup_all _ do
    Data.Product.load("data/products_test.csv")
  end

  test_with_mock "Buy 3 or more, new price of 4.00", Data.Discount,
    get_all: fn ->
      [%NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 3, new_price: 4.00}]
    end do
    assert {:ok, Float.round(5.00, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 1))

    assert {:ok, Float.round(5.00 * 2, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 2))

    assert {:ok, Float.round(4.00 * 3, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 3))

    assert {:ok, Float.round(4.00 * 4, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 4))

    assert {:ok, Float.round(4.00 * 5, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 5))

    assert {:ok, Float.round(4.00 * 6, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 6))

    assert {:ok, Float.round(4.00 * 7, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 7))
  end

  test_with_mock "Buy 1 or more, new price of 3.00", Data.Discount,
    get_all: fn ->
      [%NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 1, new_price: 3.00}]
    end do
    assert {:ok, Float.round(3.00, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 1))

    assert {:ok, Float.round(3.00 * 2, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 2))

    assert {:ok, Float.round(3.00 * 3, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 3))

    assert {:ok, Float.round(3.00 * 4, 2)} ==
             KantoxSupermarket.calculate_price(List.duplicate("SR1", 4))
  end
end
