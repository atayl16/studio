# frozen_string_literal: true

class BillingController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user.email
  end

  def new_card
    respond_to do |format|
      format.js
    end
  end

  def create_card
    respond_to do |format|
      if current_user.stripe_id.nil?
        customer = Stripe::Customer.create({ "email": current_user.email })
        current_user.update(stripe_id: customer.id)
      end

      card_token = params[:stripeToken]
      # the stripeToken that we added in the hidden input
      format.html { redirect_to billing_path, error: 'Oops' } if card_token.nil?

      customer = Stripe::Customer.new current_user.stripe_id
      customer.source = card_token
      # attach the card to the stripe customer
      customer.save

      format.html { redirect_to success_path }
    end
  end

  def success
    @plans = Stripe::Plan.list.data
  end

  def subscribe
    if current_user.stripe_id.nil?
      redirect_to success_path, flash: { error: 'Please enter your card' }
      return
    end

    customer = Stripe::Customer.new current_user.stripe_id

    subscriptions = Stripe::Subscription.list(customer: customer.id)
    subscriptions.each(&:delete)
    # delete all subscription that the customer has. We do this because we don't want our customer to have multiple subscriptions

    plan_id = params[:plan_id]
    subscription = Stripe::Subscription.create({
                                                 customer: customer,
                                                 items: [{ plan: plan_id }]
                                               })

    subscription.save
    redirect_to new_company_path
  end
end
