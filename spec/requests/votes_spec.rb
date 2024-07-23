require 'rails_helper'

RSpec.describe "/votes", type: :request do
  let(:user) { User.create(name: "Firstname Lastname", email: "example@example.com") }
  let(:poll) { Poll.create(name: "Employee of the Year") }
  let(:candidate) { Candidate.create(name: "Candidate Name", poll_id: poll.id) }
  let(:valid_attributes) {
    { candidate_id: candidate.id, user_id: user.id }
  }

  let(:invalid_attributes) {
    { bad_params: 'no' }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Vote.create! valid_attributes
      get votes_url
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["data"].first["candidate_id"]).to eq(valid_attributes[:candidate_id])
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      vote = Vote.create! valid_attributes
      get vote_url(vote)
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["data"]["candidate_id"]).to eq(valid_attributes[:candidate_id])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Vote" do
        expect {
          post votes_url, params: { vote: valid_attributes, format: :json }
        }.to change(Vote, :count).by(1)
      end
    end

    context "with invalid parameters" do
      skip "does not create a new Vote" do
        expect {
          post votes_url, params: { vote: invalid_attributes }
        }.to change(Vote, :count).by(0)
      end

    
      skip "renders a response with 422 status (i.e. to display the 'new' template)" do
        post votes_url, params: { vote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested vote" do
        vote = Vote.create! valid_attributes
        patch vote_url(vote), params: { vote: new_attributes }
        vote.reload
        skip("Add assertions for updated state")
      end

    end

    context "with invalid parameters" do
    
      skip "renders a response with 422 status (i.e. to display the 'edit' template)" do
        vote = Vote.create! valid_attributes
        patch vote_url(vote), params: { vote: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested vote" do
      vote = Vote.create! valid_attributes
      expect {
        delete vote_url(vote)
      }.to change(Vote, :count).by(-1)
    end
  end
end
