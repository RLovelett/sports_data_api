module SportsDataApi
  module Nfl
    class TeamRoster
      attr_reader :players

      def initialize(xml)
        @players = []
        xml.children.each do | player |
          if player.name == "text"
            next
          end
          @players << Player.new(player)
        end
      end
    end
  end
end
