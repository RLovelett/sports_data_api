module SportsDataApi
  module Mlb
    class Division < JsonData
      def teams
        @teams ||= division[:teams].map do |data|
          Team.new(data)
        end
      end
    end
  end
end
