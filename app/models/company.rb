# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :user
  has_many :artifacts

  after_create do
    self.user.update(:company_id => id, :type => Owner)
  end
end
