# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :artifacts, dependent: :destroy
  has_one :company
  acts_as_voter

  def stripe_customer
    return Stripe::Customer.retrieve(stripe_id) if stripe_id?
    stripe_customer = Stripe::Customer.create(email: email)
    update(stripe_id: stripe_customer.id)
    stripe_customer
  end

  def subscribed?
    stripe_subscription_id?
  end
end
