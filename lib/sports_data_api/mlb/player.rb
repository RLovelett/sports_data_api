module SportsDataApi
  module Mlb
    class Player < SportsDataApi::JsonData
      def statistics
        @statistics ||= Statistics.new(player[:statistics]) if player.has_key? :statistics
      end
    end
  end
end
