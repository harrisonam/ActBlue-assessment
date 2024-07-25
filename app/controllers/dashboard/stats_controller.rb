module Dashboard
  class StatsController < ApplicationController
    # Example Request:
    # GET /dashboard/stats?category=polls&stat_name=votes_per_poll&page=1&per_page=10
    def index
      results = StatsService.new(stats_params).results

      render json: results, status: :ok
    end

    private

    def stats_params
      params.slice(:category, :stat_name, :start_date, :end_date, :page, :per_page)
    end
  end
end
