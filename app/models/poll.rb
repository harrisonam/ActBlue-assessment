class Poll < ApplicationRecord
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  def self.with_votes_count_for_range(start_date, end_date)
    joins(candidates: :votes)
      .where(votes: { created_at: start_date..end_date })
      .group('polls.id', 'polls.name')
      .select('polls.*, COUNT(votes.id) AS votes_count')
      .order('votes_count DESC')
  end
end
