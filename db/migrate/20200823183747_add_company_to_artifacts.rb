class AddCompanyToArtifacts < ActiveRecord::Migration[5.2]
  def change
    add_reference :artifacts, :company, index: true
  end
end
