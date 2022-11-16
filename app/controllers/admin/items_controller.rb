class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def updated
    @item = Item.find(params[:id])
  end

  private
	def item_params
	  params.require(:item).permit(:name, :introduction, :image, :is_active, :price, :genre_id)
	end
end
