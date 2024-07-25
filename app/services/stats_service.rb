class StatsService
  STATS_REF = {
    'polls' => {
      'votes_per_poll' => Stats::Polls::VotesPerPoll
    }
  }.freeze

  def initialize(params = {})
    @params = params
    @category = params[:category]
    @stat_name = params[:stat_name]
    @service_klass = fetch_service_klass
  end

  def results
    if @service_klass
      @service_klass.new(@params).results
    else
      { data: {}, pagination: {}, errors: ['Stat type is not supported'] }
    end
  rescue StandardError => e
    { data: {}, pagination: {}, errors: [e.message] }
  end

  private

  def fetch_service_klass
    return unless @category && @stat_name

    STATS_REF.dig(@category, @stat_name)
  end
end
