class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product

  def add_product_to_cart(product)
    item = cart_items.where("product_id = ?", product.id)

    if item.size < 1
      ci = cart_items.build
      ci.product = product
      ci.quantity = 1
    else
      ci = item.first
      ci.update_attribute(:quantity, ci.quantity + 1)
    end

    product.quantity -= 1
    product.save

    ci.save
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
        sum += cart_item.quantity * cart_item.product.price
      end
    end
    return sum
  end

  def item_total_price(cart_item)
    # item = cart_items.where("product_id = ?", product.id)
    sum = 0

    if cart_item.product.price.present?
      sum += cart_item.quantity * cart_item.product.price
    end

    return sum
  end


  def clean!
    cart_items.destroy_all
  end
end
