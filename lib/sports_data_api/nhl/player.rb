module SportsDataApi
  module Nhl
    class Player < SportsDataApi::JsonData
      def stats
        return if player[:statistics].nil? || player[:statistics].empty?
        @stats ||= SportsDataApi::MergedStats.new(player[:statistics])
      end
    end
  end
end
