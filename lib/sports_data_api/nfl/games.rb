module SportsDataApi
  module Nfl
    class Games
      include Enumerable
      attr_reader :games, :year, :season, :week

      def initialize(xml)
        @year = xml.first['season'].to_i
        @season = xml.first['type'].to_sym
        @week = xml.first['week'].to_i

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