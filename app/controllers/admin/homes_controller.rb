class Admin::HomesController < ApplicationController
  def top
    if params[:customer_id]
      @orders = Order.where(customer_id: params[:customer_id])
    else
      @orders = Order.all
    end
  end
end
