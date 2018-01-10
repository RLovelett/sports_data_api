module SportsDataApi
  module Nhl
    class Games
      include Enumerable

      attr_reader :date

      def initialize(json)
        @json = json
        @date = json['date']
      end

      def games
        @games ||= json['games'].map do |game_json|
          Game.new(json: game_json)
        end
      end

      def each
        return games.each unless block_given?
        games.each { |game| yield game }
      end

      private

      attr_reader :json
    end
  end
end
