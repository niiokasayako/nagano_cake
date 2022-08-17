class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm
     @cart_items = current_customer.cart_items
     @total = 0
     @order = Order.new(order_params)
  end

  def complete
  end

  def index
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:payment_method)
    end

end
