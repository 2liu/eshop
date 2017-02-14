class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save

      # for order_list
      current_cart.cart_items.each do |cart_item|
        order_list = OrderList.new
        order_list.order = @order
        order_list.product_name = cart_item.product.title
        order_list.product_price = cart_item.product.price
        order_list.quantity = cart_item.quantity
        order_list.save
      end

      # clean cart
      current_cart.clean!

      redirect_to order_path(@order.token)
    else
      render "carts/checkout"
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @order_lists = @order.order_lists
  end

  private

    def order_params
      params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
    end
end
