class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    if current_order
      current_order.update(account_id: current_user.id)
    end
    if (Account.find(current_user.id)).orders.any? && current_order.id != nil
      (Order.find(current_order.id)).order_items.each do |item|
        if @test =  (Account.find(current_user.id)).orders.find(current_user.id).order_items.where(product_id: item.product_id).any? === true
          @test.update(quantity: @test.first.quantity + item.quantity)
        else
          item.update(order_id: current_user.id)
        end
      end
      Order.destroy(current_order.id)
    end
    session[:order_id] = current_user.id
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
