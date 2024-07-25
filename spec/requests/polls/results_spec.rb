require 'rails_helper'

RSpec.describe '/polls/:poll_id/results', type: :request do
  let(:poll) { create(:poll) }
  let!(:candidates) do
    [
      create(:candidate, poll:, votes_count: 10),
      create(:candidate, poll:, votes_count: 20),
      create(:candidate, poll:, votes_count: 15)
    ]
  end

  before do
    create_list(:vote, 10, candidate: candidates.first)
    create_list(:vote, 5, candidate: candidates.second)
    create_list(:vote, 7, candidate: candidates.third)
  end

  describe 'GET /index' do
    context 'when poll exists' do
      before do
        get poll_results_path(poll), params: { page: 1, per_page: 2 }, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct data' do
        json_response = JSON.parse(response.body)
        expect(json_response['data'].size).to eq(2)
        expect(json_response['data'].first['votes_count']).to be >= json_response['data'].second['votes_count']
      end

      it 'returns pagination information' do
        json_response = JSON.parse(response.body)
        expect(json_response['pagination']).to include(
          'current_page' => 1,
          'next_page' => 2,
          'prev_page' => nil,
          'total_pages' => 2,
          'total_count' => 3
        )
      end
    end

    context 'when poll does not exist' do
      before do
        get '/polls/999/results', params: { page: 1, per_page: 2 }, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'returns http not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Couldn't find Poll with 'id'=999")
      end
    end
  end
end
