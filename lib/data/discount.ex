defmodule Data.Discount do
  alias Discounts.{
    BuySomeGetSomeFree,
    Discount,
    DiscountForBuyingMoreThan,
    NewPriceForBuyingMoreThan
  }

  @discounts_file "data/discounts.json"

  @spec get_all :: list(Discount.t())
  def get_all do
    @discounts_file
    |> File.read!()
    |> Jason.decode!()
    |> Enum.map(&decode_discount/1)
  end

  defp decode_discount(%{
         "discount" => "buy_some_get_some_free",
         "product_id" => product_id,
         "needed_products" => needed_products,
         "free_products" => free_products
       }) do
    %BuySomeGetSomeFree{
      product_id: product_id,
      needed_products: needed_products,
      free_products: free_products
    }
  end

  defp decode_discount(%{
         "discount" => "discount_for_buying_more_than",
         "product_id" => product_id,
         "minimum_units" => minimum_units,
         "discount_rate" => discount_rate
       }) do
    %DiscountForBuyingMoreThan{
      product_id: product_id,
      minimum_units: minimum_units,
      discount_rate: discount_rate
    }
  end

  defp decode_discount(%{
         "discount" => "new_price_for_buying_more_than",
         "product_id" => product_id,
         "minimum_units" => minimum_units,
         "new_price" => new_price
       }) do
    %NewPriceForBuyingMoreThan{
      product_id: product_id,
      minimum_units: minimum_units,
      new_price: new_price
    }
  end
end
