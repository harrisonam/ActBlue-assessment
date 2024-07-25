require 'rails_helper'

RSpec.describe '/dashboard/stats', type: :request do
  let!(:polls) { create_list(:poll, 3) }
  let!(:candidates) do
    create_list(:candidate, 2, poll: polls[0], votes_count: 10) +
      create_list(:candidate, 2, poll: polls[1], votes_count: 20) +
      create_list(:candidate, 2, poll: polls[2], votes_count: 15)
  end

  before do
    candidates.each do |candidate|
      create_list(:vote, 10 + candidate.votes_count, candidate:)
    end
  end

  describe 'GET /dashboard/stats' do
    context 'when valid category and stat_name are provided' do
      before do
        get dashboard_stats_path, params: { stat_name: 'votes_per_poll', category: 'polls' },
                                    headers: { 'ACCEPT' => 'application/json' }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct data' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to be_an(Array)
        expect(json_response['data'].size).to be_positive
        expect(json_response['data'].first).to include('id', 'name', 'votes_count')
      end

      it 'returns pagination information' do
        json_response = JSON.parse(response.body)
        expect(json_response['pagination']).to include(
          'current_page' => 1,
          'next_page' => nil,
          'prev_page' => nil,
          'total_pages' => 1,
          'total_count' => Poll.count
        )
      end
    end

    context 'when invalid category or stat_name is provided' do
      before do
        get dashboard_stats_path, params: { stat_name: 'invalid_stat', category: 'polls' },
                                    headers: { 'ACCEPT' => 'application/json' }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to be_empty
        expect(json_response['pagination']).to be_empty
        expect(json_response['errors']).to include('Stat type is not supported')
      end
    end

    context 'when missing parameters' do
      before do
        get dashboard_stats_path, headers: { 'ACCEPT' => 'application/json' }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an error message' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to be_empty
        expect(json_response['pagination']).to be_empty
        expect(json_response['errors']).to include('Stat type is not supported')
      end
    end
  end
end
