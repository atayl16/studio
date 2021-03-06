# frozen_string_literal: true

class AddAttachmentImageToArtifacts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :artifacts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :artifacts, :image
  end
end
