class Admin::OrdersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @order = Order.find(params[:id])
    @order_details = Order_details.all
  end
end
