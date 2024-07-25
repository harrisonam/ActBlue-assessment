class Polls::ResultsController < ApplicationController
  before_action :set_poll, only: :index

  # GET /polls/:poll_id/results or /polls/:poll_id/results.json
  def index
    poll_results = Candidate
                   .where(poll: @poll)
                   .select(:id, :name, :votes_count)
                   .order(votes_count: :desc)
                   .page(params[:page])
                   .per(params[:per_page])

    render json: { data: poll_results,
                   pagination: {
                     current_page: poll_results.current_page,
                     next_page: poll_results.next_page,
                     prev_page: poll_results.prev_page,
                     total_pages: poll_results.total_pages,
                     total_count: poll_results.total_count
                   } }, status: :ok
  end

  private

  def set_poll
    @poll = Poll.find(params[:poll_id])
  end
end
