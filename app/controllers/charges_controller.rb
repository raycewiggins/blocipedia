class ChargesController < ApplicationController
  def new
    upgrade_account
  end

  def create
    @amount = 1500

    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Rails Stripe Customer - #{current_user.email}",
      currency: 'usd'
    )

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
