module SportsDataApi
  module Nfl
    class Season
      attr_reader :year, :type

      def initialize(json)
        @json = json
        @id = json['id']
        @year = json['year']
        @type = json['type'].to_sym
      end

      def weeks
        @weeks ||= json.fetch('weeks', []).map do |week|
          Week.new(week, year, type)
        end
      end

      private

      attr_reader :json
    end
  end
end
