module SportsDataApi
  module Nfl
    class TeamRoster
      attr_reader :players

      def initialize(json)
        @players = []
        json['players'].each do | player |
          @players << Player.new(player)
        end
      end
    end
  end
end
