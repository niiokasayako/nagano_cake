class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += cart_item_params[:amount].to_i
      @cart_item.update(amount: @cart_item.amount)
      redirect_to public_cart_items_index_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      @cart_item.save
      redirect_to public_cart_items_index_path
    end
  end

  def update
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.update(amount: params[:amount])
      redirect_to public_cart_items_index_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to public_cart_items_index_path
  end

  def destroy_all
    @cart_item = CartItem.destroy_all
    @cart_item.destroy
    redirect_to public_cart_items_index_path
  end

   #投稿データのストロングパラメータ
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
