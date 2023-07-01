defmodule KantoxSupermarketTest do
  use ExUnit.Case
  import Mock

  alias Discounts.{BuySomeGetSomeFree, DiscountForBuyingMoreThan, NewPriceForBuyingMoreThan}

  setup_all _ do
    Data.Product.load("data/products_test.csv")
  end

  test "Predefined scenarios of the exercise" do
    assert {:ok, 22.45} == KantoxSupermarket.calculate_price(["GR1", "SR1", "GR1", "GR1", "CF1"])
    assert {:ok, 3.11} == KantoxSupermarket.calculate_price(["GR1", "GR1"])
    assert {:ok, 16.61} == KantoxSupermarket.calculate_price(["SR1", "SR1", "GR1", "SR1"])
    assert {:ok, 30.57} == KantoxSupermarket.calculate_price(["GR1", "CF1", "SR1", "CF1", "CF1"])
  end

  test_with_mock "Mixed products", Data.Discount,
    get_all: fn ->
      [
        %BuySomeGetSomeFree{product_id: "GR1", needed_products: 1, free_products: 1},
        %NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 3, new_price: 4.50},
        %DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 3, discount_rate: 2 / 3}
      ]
    end do
    # One discount at a time
    assert {:ok, 35.57} ==
             KantoxSupermarket.calculate_price(["GR1", "SR1", "CF1", "GR1", "SR1", "CF1"])

    assert {:ok, 39.07} ==
             KantoxSupermarket.calculate_price(["SR1", "GR1", "SR1", "CF1", "SR1", "CF1"])

    assert {:ok, 35.57} ==
             KantoxSupermarket.calculate_price(["CF1", "GR1", "CF1", "SR1", "CF1", "SR1"])

    # Two discounts at the same time
    assert {:ok, 39.07} ==
             KantoxSupermarket.calculate_price(["GR1", "SR1", "CF1", "SR1", "CF1", "SR1", "CF1"])

    assert {:ok, 39.07} ==
             KantoxSupermarket.calculate_price(["SR1", "GR1", "SR1", "CF1", "SR1", "CF1", "GR1"])

    assert {:ok, 35.57} ==
             KantoxSupermarket.calculate_price(["CF1", "GR1", "CF1", "SR1", "CF1", "SR1", "GR1"])

    # All discounts at the same time
    assert {:ok, 39.07} ==
             KantoxSupermarket.calculate_price([
               "GR1",
               "SR1",
               "CF1",
               "SR1",
               "CF1",
               "SR1",
               "CF1",
               "GR1"
             ])
  end

  test_with_mock "Error scenarios", Data.Discount,
    get_all: fn ->
      [
        %BuySomeGetSomeFree{product_id: "GR1", needed_products: 1, free_products: 1},
        %NewPriceForBuyingMoreThan{product_id: "SR1", minimum_units: 3, new_price: 4.50},
        %DiscountForBuyingMoreThan{product_id: "CF1", minimum_units: 3, discount_rate: 2 / 3}
      ]
    end do
    assert {:ok, 0.00} == KantoxSupermarket.calculate_price([])

    assert {:error, "Please provide a list of product ids"} ==
             KantoxSupermarket.calculate_price("SR1")

    assert {:error, "Please provide a list of product ids"} ==
             KantoxSupermarket.calculate_price(nil)

    assert {:error, "Product id \"XZ1\" not recognized"} ==
             KantoxSupermarket.calculate_price(["SR1", "CF1", "XZ1", "GR1"])
  end
end
