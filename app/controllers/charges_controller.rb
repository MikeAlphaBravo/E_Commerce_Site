class ChargesController < ApplicationController
  def new
    @amount = view_context.number_with_precision(current_order.total_price, precision: 2).to_i * 100
    @total = view_context.number_to_currency current_order.total_price
  end

  def create
    # Amount in cents
    @total = view_context.number_to_currency current_order.total_price
    @amount = view_context.number_with_precision(current_order.total_price, precision: 2).to_i * 100
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    current_order.update(status: 'paid')

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
