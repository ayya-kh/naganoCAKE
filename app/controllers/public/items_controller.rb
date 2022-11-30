class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    # form_withのための空のインスタンス
    @cart_item = CartItem.new
  end
end
