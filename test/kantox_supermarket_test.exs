defmodule KantoxSupermarketTest do
  use ExUnit.Case
  doctest KantoxSupermarket

  test "greets the world" do
    assert KantoxSupermarket.hello() == :world
  end
end
