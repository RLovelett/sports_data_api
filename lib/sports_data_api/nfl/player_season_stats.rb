module SportsDataApi
  module Nfl
    class PlayerSeasonStats
      attr_reader :stats, :id, :players
      def initialize(json)
        @players = []
        json['players'].each do | p |
          player = {}
          player[:id] = p['id']
          player[:stats] = p['statistics']
          @players << player
        end
      end
    end
  end
end
