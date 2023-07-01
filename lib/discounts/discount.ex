defprotocol Discounts.Discount do
  alias Data.Product
  alias Discounts.{BuySomeGetSomeFree, DiscountForBuyingMoreThan, NewPriceForBuyingMoreThan}

  @type t ::
          BuySomeGetSomeFree.t() | DiscountForBuyingMoreThan.t() | NewPriceForBuyingMoreThan.t()

  @spec apply(t(), list(Product.t())) :: list(Product.t())
  def apply(discount, basket)
end
