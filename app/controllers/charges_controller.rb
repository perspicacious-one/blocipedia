require "amount"
class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :assert_standard_user

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      metadata: {role: "Premium"},
      currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.name}! Feel free to pay me again."
    if charge.metadata.role == "Premium" && customer.email == current_user.email

      current_user.update!(role: "premium")
    else
      flash[:alert] = "There seems to be something wrong. Please contact us."
    end
    redirect_to root_path # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership \n #{current_user.email}",
      amount: Amount.default
    }
  end

  private

  def assert_standard_user
    if current_user.role == "premium"
      flash[:notice] = "You have already purchased!"
      redirect_to root_path
    elsif current_user.role == "admin"
      flash[:notice] = "You are an admin. No need to buy anything."
      redirect_to root_path
    end
  end
end
