module SportsDataApi
  module Mlb
    class Team < SportsDataApi::JsonData
      def players
        @players ||= map_players :players
      end

      def roster
        @rosters ||= map_players :roster
      end

      def expected_players
        @expected_players ||= map_players :expected_players
      end

      def starting_pitcher
        @starting_pitcher ||= populate_model :starting_pitcher, Player
      end

      def probable_pitcher
        @probable_pitcher ||= populate_model :probable_pitcher, Player
      end

      def scoring
        @scoring ||= populate_model :scoring, Scoring
      end

      private

      def map_players(key)
        team.fetch(key, []).map do |data|
          Player.new(data)
        end
      end

      def populate_model(key, klass)
        klass.new(team[key]) if team.has_key?(key)
      end
    end
  end
end
