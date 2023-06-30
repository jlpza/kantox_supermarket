defprotocol Discounts.Discount do
  def apply(discount, basket)
end
