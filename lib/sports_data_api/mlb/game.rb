module SportsDataApi
  module Mlb
    class Game < SportsDataApi::JsonData
      def home
        @home ||= Team.new(game[:home])
      end

      def away
        @away ||= Team.new(game[:away])
      end

      def home_team_id
        @home_team_id ||= home[:id]
      end

      def away_team_id
        @away_team_id ||= away[:id]
      end
    end
  end
end
