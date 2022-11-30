class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    if cart_items = CartItem.where(customer_id: current_customer.id).present?
      @order = Order.new
      @customer = Customer.find(current_customer.id)
      @customer_address = Address.where(customer_id: current_customer.id)
    else
      redirect_to cart_items_path
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    cart_item = CartItem.where(customer_id: current_customer.id)
    cart_item.each do |cart_item|
      OrderDetail.create(
        item_id: cart_item.item.id,
        order_id: @order.id,
        amount: cart_item.amount,
        price: cart_item.item.tax_price
        )
    end
    cart_item.destroy_all
    redirect_to orders_complete_path
  end

  def confirm
    @order = Order.new
    @cart_item = CartItem.where(customer_id: current_customer.id)
    # 合計金額
    @tax_total_price = 0
    @cart_item.each do |cart_item|
      @tax_total_price += cart_item.item.tax_price * cart_item.amount
    # orderの処理
    @order.shipping_cost = 800
    @order.total_payment = @tax_total_price + @order.shipping_cost
    @order.payment_method = params[:order][:payment_method]
    @order.customer_id = current_customer.id
      if params[:order][:address_option] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
      elsif params[:order][:address_option] == "1"
        @address = Address.find(params[:customer_address])
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end
      if @order.invalid?
        @customer = Customer.find(current_customer.id)
        @customer_address = Address.where(customer_id: current_customer.id)
        render :new
      end
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end
end
