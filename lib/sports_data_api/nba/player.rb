module SportsDataApi
  module Nba
    class Player < SportsDataApi::JsonData
      def stats
        return if player[:statistics].nil? || player[:statistics].empty?
        @stats ||= SportsDataApi::Nba::Stats.new(player[:statistics])
      end
    end
  end
end
