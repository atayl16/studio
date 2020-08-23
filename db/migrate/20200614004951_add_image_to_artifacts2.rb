# frozen_string_literal: true

class AddImageToArtifacts2 < ActiveRecord::Migration[5.2]
  def change
    def change
      def self.up
        add_attachment :artifacts, :image
      end

      def self.down
        remove_attachment :artifacts, :image
      end
    end
  end
end
