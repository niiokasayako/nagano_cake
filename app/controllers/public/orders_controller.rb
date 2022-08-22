class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm
     @cart_items = current_customer.cart_items
     @total = 0
     @order = Order.new(order_params)
     if params[:order][:address_number] == "1"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
     else
        @order = Order.new(order_params)
     end
  end

  def complete
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount)
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_orders_complete_path
  end

  def index
    @order_details = OrderDetail.all
    @orders = Order.all
  end

  def show
     @order_detail = OrderDetail.find(params[:id])
     @order_details = OrderDetail.all
  end

  private
    def order_params
      params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
    end

end
