require 'rails_helper'

RSpec.describe "/candidates", type: :request do
  let (:poll) { Poll.create( name:'Employee of the Year') }

  let(:valid_attributes) {
    { name: 'Firstname Lastname', poll_id: poll.id }
  }

  let(:invalid_attributes) {
    { bad_params: 'no' }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Candidate.create! valid_attributes
      get candidates_url
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["data"].first["name"]).to eq(valid_attributes[:name])
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      candidate = Candidate.create! valid_attributes
      get candidate_url(candidate)
      expect(response).to be_successful
      body = JSON.parse(response.body)
      expect(body["data"]["name"]).to eq(valid_attributes[:name])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Candidate" do
        expect {
          post candidates_url, params: { candidate: valid_attributes, format: :json }
        }.to change(Candidate, :count).by(1)
      end
    end

    context "with invalid parameters" do
      skip "does not create a new Candidate" do
        expect {
          post candidates_url, params: { candidate: invalid_attributes, format: :json }
        }.to change(Candidate, :count).by(0)
      end

    
      skip "renders a response with 422 status (i.e. to display the 'new' template)" do
        post candidates_url, params: { candidate: invalid_attributes, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested candidate" do
        candidate = Candidate.create! valid_attributes
        patch candidate_url(candidate), params: { candidate: new_attributes, format: :json }
        candidate.reload
        skip("Add assertions for updated state")
      end
    end

    context "with invalid parameters" do
    
      skip "renders a response with 422 status (i.e. to display the 'edit' template)" do
        candidate = Candidate.create! valid_attributes
        patch candidate_url(candidate), params: { candidate: invalid_attributes, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested candidate" do
      candidate = Candidate.create! valid_attributes
      expect {
        delete candidate_url(candidate)
      }.to change(Candidate, :count).by(-1)
    end
  end
end
