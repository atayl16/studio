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
      customer.save

      format.html { redirect_to success_path }
    end
  end

  def success
    @plans = Stripe::Plan.list.data
  end

  def subscribe
    if current_user.stripe_id.nil?
      redirect_to create_card_path, flash: { error: 'Please enter your card' }
      return
    end
    customer = Stripe::Customer.new current_user.stripe_id
    subscriptions = Stripe::Subscription.list(customer: customer.id)
    subscriptions.each(&:delete)
    plan_id = params[:plan_id]
    subscription = Stripe::Subscription.create({customer: customer, items: [{ plan: plan_id }]
      })
    subscription.save
    current_user.assign_attributes(stripe_subscription_id: subscription.id)
    redirect_to new_company_path, notice: 'Thanks for subscribing!'
  end
end
