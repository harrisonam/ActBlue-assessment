require 'rails_helper'

RSpec.describe Poll, type: :model do
  describe 'associations' do
    it { should have_many(:candidates) }
    it { should have_many(:votes).through(:candidates) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '.with_votes_count_for_range' do
    let!(:poll_1) { create(:poll, name: 'Poll 1') }
    let!(:poll_2) { create(:poll, name: 'Poll 2') }
    let!(:candidate_1) { create(:candidate, poll: poll_1) }
    let!(:candidate_2) { create(:candidate, poll: poll_2) }

    before do
      create_list(:vote, 5, candidate: candidate_1, created_at: 2.days.ago)
      create_list(:vote, 3, candidate: candidate_2, created_at: 2.days.ago)
      create_list(:vote, 2, candidate: candidate_1, created_at: 10.days.ago)
    end

    it 'returns polls with votes count within the given range' do
      results = Poll.with_votes_count_for_range(1.week.ago.beginning_of_day, Time.current.end_of_day)

      expect(results.to_a.size).to eq(2)

      poll_1_result = results.find { |r| r.id == poll_1.id }
      poll_2_result = results.find { |r| r.id == poll_2.id }

      expect(poll_1_result.votes_count).to eq(5)
      expect(poll_2_result.votes_count).to eq(3)
    end

    it 'excludes votes outside the given range' do
      results = Poll.with_votes_count_for_range(1.week.ago.beginning_of_day, Time.current.end_of_day)
      poll_1_result = results.find { |r| r.id == poll_1.id }
      expect(poll_1_result.votes_count).to eq(5)
    end
  end
end
