defmodule KantoxSupermarket do
  @moduledoc """
  Documentation for `KantoxSupermarket`.
  """
  alias Discounts.Discount

  @spec calculate_price(basket :: list(String.t())) ::
          {:ok, price :: float()} | {:error, String.t()}
  def calculate_price(basket) when is_list(basket) do
    case get_products(basket, []) do
      {:error, _} = error ->
        error

      products ->
        Data.Discount.get_all()
        |> Enum.reduce(products, &Discount.apply/2)
        |> Enum.reduce(0.00, fn %Data.Product{price: price}, acc -> acc + price end)
        |> Float.round(2)
        |> then(&{:ok, &1})
    end
  end

  def calculate_price(_other), do: {:error, "Please provide a list of product ids"}

  defp get_products([], acc), do: acc

  defp get_products([product_id | basket], acc) do
    case Data.Product.get(product_id) do
      {:ok, product} -> get_products(basket, [product | acc])
      {:error, _} = error -> error
    end
  end
end
