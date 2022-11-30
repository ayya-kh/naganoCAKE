class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.where(customer_id: current_customer.id)
    @total_price = 0
    @cart_item.each do |cart_item|
      @total_price += cart_item.item.tax_price * cart_item.amount
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    cart_item = CartItem.find_by(item_id: cart_item_params[:item_id], customer_id: current_customer.id)
    if cart_item.present?
      cart_item.amount += @cart_item.amount
      cart_item.save
    else
      @cart_item.save
    end
    redirect_to cart_items_path(@cart_items)
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.customer_id == current_customer.id
      if cart_item.update(cart_item_params)
        flash[:notice] = "商品の個数を変更しました"
      else
        flash[:alert] = "商品個数の変更に失敗しました"
      end
    end
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.customer_id == current_customer.id
      cart_item.destroy
    end
    redirect_to cart_items_path
  end

  def destroy_all
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
