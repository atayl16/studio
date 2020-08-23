# frozen_string_literal: true

class AddImageToArtifacts < ActiveRecord::Migration[5.2]
  def change
    def self.up
      add_attachment :artifacts, :image
    end
  end

  def self.down
    remove_attachment :artifacts, :image
  end
end
