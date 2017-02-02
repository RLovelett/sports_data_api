module SportsDataApi
  module Golf
    class Summary
      attr_reader :tour, :year, :id, :name, :purse, :winning_share, :currency,
        :points, :event_type, :start_date, :end_date, :course_timezone,
        :coverage, :status

      def initialize(tour, year, data)
        @tour = tour
        @year = year
        @data = data
        @id = data['id']
        @name = data['name']
        @purse = data['purse']
        @winning_share = data['winning_share']
        @currency = data['currency']
        @points = data['points']
        @event_type = data['event_type']
        @start_date = data['start_date']
        @end_date = data['end_date']
        @course_timezone = data['course_timezone']
        @coverage = data['coverage']
        @status = data['status']
      end

      def field
        @field ||= data['field'].map do |json|
          SportsDataApi::Golf::Player.new(json)
        end if data['field']
      end

      def rounds
        @rounds ||= data['rounds'].map do |json|
          SportsDataApi::Golf::Round.new(json)
        end if data['rounds']
      end

      private

      attr_reader :data
    end
  end
end
