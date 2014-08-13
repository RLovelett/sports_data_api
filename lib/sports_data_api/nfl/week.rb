module SportsDataApi
  module Nfl
    class Week
      attr_reader :number, :games, :year, :season

      def initialize(year, season, week_hash)
        @games = []
        @year = year
        @season = season

        @number = week_hash['number']
        @games = week_hash['games'].map do |game_hash|
          Game.new(@year, @season, @number, game_hash)
        end
      end
    end
  end
end
