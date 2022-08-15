class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_item.all
  end

  def create
    @cart_item = Cart_item.new(cart_item_params)
    if @cart_item.save
      flash[:notice] = "You have created item successfully."
      redirect_to new_orders_path
    else
      @cart_items = Cart_item.all
      render :index
    end
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

   #投稿データのストロングパラメータ
  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
