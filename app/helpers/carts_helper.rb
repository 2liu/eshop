module CartsHelper

  def render_cart_total_price(cart)
    cart.total_price
  end

  def render_cart_item_total_price(cart, cart_item)
    cart.item_total_price(cart_item)
  end
end
