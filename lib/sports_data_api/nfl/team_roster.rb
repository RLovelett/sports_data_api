module SportsDataApi
  module Nfl
    class TeamRoster
      attr_reader :players

      def initialize(json)
        @players = json['players'].map do |player|
          Player.new(player)
        end
      end
    end
  end
end
