module SportsDataApi
  module Nfl
    class Games
      include Enumerable
      attr_reader :games

      def initialize(xml)
        @games = xml.xpath("game").map do |game_xml|
          Game.new(game_xml)
        end
      end

      def each &block
        @games.each do |game|
          if block_given?
            block.call game
          else
            yield game
          end
        end
      end

    end
  end
end