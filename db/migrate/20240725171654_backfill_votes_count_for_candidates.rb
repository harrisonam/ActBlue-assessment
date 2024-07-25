class BackfillVotesCountForCandidates < ActiveRecord::Migration[6.1]
  def up
    puts 'Votes backfill for candidates started!'

    Candidate.find_each do |candidate|
      Candidate.reset_counters(candidate.id, :votes)
    end

    puts 'Backfill finished!'
  end

  def down
  end
end
