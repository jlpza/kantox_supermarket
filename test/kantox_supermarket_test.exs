defmodule KantoxSupermarketTest do
  use ExUnit.Case
  doctest KantoxSupermarket

  setup_all _ do
    Data.load_products()
  end

  test "greets the world" do
    assert 22.45 == KantoxSupermarket.calculate_price(["GR1", "SR1", "GR1", "GR1", "CF1"])
    assert 3.11 == KantoxSupermarket.calculate_price(["GR1", "GR1"])
    assert 16.61 == KantoxSupermarket.calculate_price(["SR1", "SR1", "GR1", "SR1"])
    assert 30.57 == KantoxSupermarket.calculate_price(["GR1", "CF1", "SR1", "CF1", "CF1"])
  end
end
