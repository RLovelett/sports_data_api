module SportsDataApi
  module Golf
    class Tournament
      attr_reader :tour, :year, :id, :name, :event_type, :purse,
        :winning_share, :currency, :points, :course_timezone,
        :start_date, :end_date

      def initialize(tour, year, data)
        @tour = tour
        @year = year
        @id = data['id']
        @name = data['name']
        @event_type = data['event_type']
        @purse = data['purse']
        @winning_share = data['winning_share']
        @currency = data['currency']
        @points = data['points']
        @course_timezone = data['course_timezone']
        @start_date = Date.parse data['start_date']
        @end_date = Date.parse data['end_date']
      end

      def summary(version = DEFAULT_VERSION)
        Golf.summary(tour, year, id, version)
      end
    end
  end
end
