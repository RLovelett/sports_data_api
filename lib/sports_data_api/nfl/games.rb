module SportsDataApi
  module Nfl
    class Games
      include Enumerable
      attr_reader :games, :year, :season, :week

      def initialize(year, season, week, games_hash)
        @year = year
        @season = season
        @week = week

        @games = games_hash['games'].map do |game_hash|
          Game.new(@year, @season, @week, game_hash)
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
