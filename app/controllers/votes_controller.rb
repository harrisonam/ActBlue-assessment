class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show update destroy ]

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
    render json: { data: @votes }, status: :ok
  end

  # GET /votes/1 or /votes/1.json
  def show
    render json: { data: @vote }, status: :ok
  end

  def edit
  end

  # POST /votes or /votes.json
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      render json: { data: @vote }, status: :ok 
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
      if @vote.update(vote_params)
        render json: { data: @vote }, status: :ok
      else
        render json: @vote.errors, status: :unprocessable_entity
      end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:user_id, :candidate_id)
    end
end
