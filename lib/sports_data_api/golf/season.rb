module SportsDataApi
  module Golf
    class Season
      VALID_TOURS = %i(pga euro).freeze

      attr_reader :year, :tour, :tournaments

      def initialize(season_hash)
        @year = season_hash['season']['year']
        @tour = season_hash['tour']['alias'].downcase.to_sym
        @tournaments = season_hash['tournaments'].map do |tournament_hash|
          Tournament.new(tour, year, tournament_hash)
        end
      end
    end
  end
end
