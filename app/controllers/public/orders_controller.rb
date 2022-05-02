class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm

    if params[:order][:address_number] == "1"
      @order = Order.new(order_params)
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_name = current_customer.last_name + current_customer.first_name
      @order.delivery_address = current_customer.address

    elsif params[:order][:address_number] == "2"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_address = @address.address
      @order.delivery_name = @address.name

    elsif params[:order][:address_number] == "3"
      @order = Order.new(order_params)
    end
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def complete
  end

  def create
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address, :delivery_name, :postage, :billing_amount, :payment_method, :status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
