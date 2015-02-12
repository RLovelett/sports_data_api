module SportsDataApi
  module Ncaamb
    class Games
      include Enumerable
      attr_reader :games, :date

      def initialize(xml)
        @date = xml.first['date']
        
        @games = xml.xpath("games/game").map do |game_xml|
          Game.new(date: @date, xml: game_xml)
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
