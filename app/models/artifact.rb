# frozen_string_literal: true

class Artifact < ApplicationRecord
  acts_as_votable
  belongs_to :user, optional: true
  has_one :company, :through => :user
  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}
end
