module SportsDataApi
  module Nfl
    class Week
      attr_reader :number, :year, :season

      def initialize(json, year, season)
        @json = json
        @year = year
        @season = season
        @number = json['sequence']
      end

      def games
        @games ||= json.fetch('games', []).map do |game|
          Game.new(game, year: year, season: season, week: number)
        end
      end

      private

      attr_reader :json
    end
  end
end
