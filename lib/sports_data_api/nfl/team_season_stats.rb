module SportsDataApi
  module Nfl
    class TeamSeasonStats
      attr_reader :id, :stats
      def initialize(json)
        @id = json['id']
        @stats = []
        json['statistics'].each_pair do | key, val |
          @stats << { key: val }
        end
      end
    end
  end
end
