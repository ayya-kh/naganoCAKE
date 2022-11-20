class Public::HomesController < ApplicationController
  def top
    @item = Item.all
  end

  def about
  end
end
