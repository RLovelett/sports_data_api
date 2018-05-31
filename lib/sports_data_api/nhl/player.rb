module SportsDataApi
  module Nhl
    class Player < SportsDataApi::JsonData
      GOALIE_POSITION = 'G'.freeze

      def stats
        return if player[stats_key].nil? || player[stats_key].empty?
        @stats ||= SportsDataApi::MergedStats.new(player[stats_key])
      end

      def goalie?
        player[:primary_position] == GOALIE_POSITION
      end

      private

      def stats_key
        goalie? ? :goaltending : :statistics
      end
    end
  end
end
