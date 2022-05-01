class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
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
end
