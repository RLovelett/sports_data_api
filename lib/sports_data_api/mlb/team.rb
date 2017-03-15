module SportsDataApi
  module Mlb
    class Team < SportsDataApi::JsonData
      def players
        @players ||= map_players(:players)
      end

      def roster
        @rosters ||= map_players(:roster)
      end

      def starting_pitcher
        @starting_pitcher ||= populate_player(:starting_pitcher)
      end

      def probable_pitcher
        @probable_pitcher ||= populate_player(:probable_pitcher)
      end

      private

      def map_players(key)
        team.fetch(key, []).map do |data|
          Player.new(data)
        end
      end

      def populate_player(key)
        Player.new(team[key]) if team.has_key?(key)
      end
    end
  end
end
