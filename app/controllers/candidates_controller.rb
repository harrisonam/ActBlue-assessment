class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[ show update destroy ]

  # GET /candidates or /candidates.json
  def index
    @candidates = Candidate.all
    render json: { data: @candidates }, status: :ok
  end

  # GET /candidates/1 or /candidates/1.json
  def show
    render json: { data: @candidate }, status: :ok
  end

  # POST /candidates or /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      render json: { data: @candidate }, status: :ok 
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /candidates/1 or /candidates/1.json
  def update
    if @candidate.update(candidate_params)
      render json: { data: @candidate }, status: :ok
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /candidates/1 or /candidates/1.json
  def destroy
    @candidate.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:name, :poll_id)
    end
end
