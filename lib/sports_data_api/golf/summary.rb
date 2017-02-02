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
        @field ||= safe_map('field') do |json|
          SportsDataApi::Golf::Player.new(json)
        end
      end

      def rounds
        @rounds ||= safe_map('rounds') do |json|
          SportsDataApi::Golf::Round.new(json)
        end
      end

      private

      attr_reader :data

      def safe_map(field)
        data[field].map { |val| yield(val) } if data[field]
      end
    end
  end
end
