class AddArtifactToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :artifact, :string
  end
end
