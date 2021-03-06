# frozen_string_literal: true

class AddDescriptionToArtifacts < ActiveRecord::Migration[5.2]
  def change
    add_column :artifacts, :description, :text
  end
end
