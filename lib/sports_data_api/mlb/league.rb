module SportsDataApi
  module Mlb
    class League < JsonData
      def divisions
        @divisions ||= league[:divisions].map do |data|
          Division.new(data)
        end
      end
    end
  end
end
