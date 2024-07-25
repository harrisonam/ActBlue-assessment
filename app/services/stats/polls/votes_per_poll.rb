module Stats
  module Polls
    class VotesPerPoll
      def initialize(params = {})
        @start_date = params[:start_date] || 1.week.ago.beginning_of_day
        @end_date = params[:end_date] || Time.current.end_of_day
        @page = params[:page] || 1
        @per_page = params[:per_page] || 10
      end

      def results
        # TODO: create a pagination service and separate out pagination handling
        polls = Poll.with_votes_count_for_range(@start_date, @end_date).page(@page).per(@per_page)
        {
          data: polls,
          pagination: {
            current_page: polls.current_page,
            next_page: polls.next_page,
            prev_page: polls.prev_page,
            total_pages: polls.total_pages,
            total_count: polls.total_count
          }
        }
      end
    end
  end
end
