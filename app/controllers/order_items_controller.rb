class OrderItemsController < ApplicationController
  def create
    @order = current_order
    # @item = @order.order_items.new(item_params)
    if current_user && Account.find(current_user.id).orders.first.order_items.where(product_id:  item_params[:product_id]).any?
      if @test = @order.order_items.where(product_id: item_params[:product_id])
        @test.update(quantity: @test.first.quantity + item_params[:quantity].to_i)
        @order.save
      end
    else
      @item = @order.order_items.new(item_params)
      @order.save
    end
    if current_user
      @order.update(account_id: current_user.id)
    end
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    # binding.pry
    @item.destroy
    @order.save
    @total = current_order.total_price
    # @total = number_to_currency current_order.total_price
    # binding.pry
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.js { render 'carts/destroy' }
    end
  end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
