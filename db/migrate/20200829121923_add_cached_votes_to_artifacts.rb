class AddCachedVotesToArtifacts < ActiveRecord::Migration[5.2]
  def change
    change_table :artifacts do |t|
      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, default: 0
    end

    # Uncomment this line to force caching of existing votes
    Artifact.find_each(&:update_cached_votes)
  end
end
