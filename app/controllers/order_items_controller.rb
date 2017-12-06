class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @item = @order.order_items.new(item_params)
    @order.save
    if current_user
      @order.update(account_id: current_user.id)
    end
    session[:order_id] = @order.id
    binding.pry
    redirect_to products_path
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.destroy
    @order.save
    redirect_to cart_path
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
