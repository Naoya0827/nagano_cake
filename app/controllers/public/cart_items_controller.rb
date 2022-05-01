class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
  end

  def update
  end

  def destroy
  end

  def destroy_all

  end

  def create
    @item = Item.find(cart_item_params[:item_id])
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
