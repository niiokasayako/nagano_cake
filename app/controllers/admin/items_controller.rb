class Admin::ItemsController < ApplicationController
  
 def new
   @item = Item.new
 end
 
 def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "You have created item successfully."
      @item = Item.find(params[:id])
      redirect_to admin_item_path(@item)
    else
      @items = Item.all
      render :index
    end
 end
 
 def index
   @item = Item.new
   @items = Item.all
 end
 
 def show
   @item = Item.find(params[:id])
 end
 
 def edit
   @item = Item.find(params[:id])
 end
 
 def update
   @item = Item.find(params[:id])
   @item.update
   redirect_to admin_item_path(@item)
 end
 
 private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price)
  end
 
end
