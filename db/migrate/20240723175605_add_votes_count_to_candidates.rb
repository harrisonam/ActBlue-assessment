class AddVotesCountToCandidates < ActiveRecord::Migration[7.1]
  def change
    add_column :candidates, :votes_count, :integer, default: 0
  end
end
