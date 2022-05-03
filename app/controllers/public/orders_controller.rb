class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new
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
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount

      order_detail.save
    end
    redirect_to public_orders_complete_path
    cart_items.destroy_all

  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :delivery_postal_code, :delivery_address, :delivery_name, :postage, :billing_amount, :payment_method, :status)
  end

  def address_params
    params.require(:order).permit(:name, :address, :postal_code)
  end
end
