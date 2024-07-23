class PollsController < ApplicationController
  before_action :set_poll, only: %i[ show update destroy ]

  # GET /polls or /polls.json
  def index
    @polls = Poll.all
    render json: { data: @polls }, status: :ok
  end

  # GET /polls/1 or /polls/1.json
  def show
    render json: { data: @poll }, status: :ok
  end

  # POST /polls or /polls.json
  def create
    @poll = Poll.new(poll_params)

    if @poll.save
      render json: { data: @poll }, status: :ok 
    else
      render json: @poll.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /polls/1 or /polls/1.json
  def update
      if @poll.update(poll_params)
        binding.pry
        render json: { data: @poll }, status: :ok
      else
        render json: @poll.errors, status: :unprocessable_entity
      end
  end

  # DELETE /polls/1 or /polls/1.json
  def destroy
    @poll.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poll_params
      params.require(:poll).permit(:name)
    end
end
