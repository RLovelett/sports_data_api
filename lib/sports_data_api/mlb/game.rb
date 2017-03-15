module SportsDataApi
  module Mlb
    class Game < SportsDataApi::JsonData
      def home
        @home ||= Team.new(game[:home])
      end

      def away
        @away ||= Team.new(game[:away])
      end
    end
  end
end
