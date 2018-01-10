module SportsDataApi
  module Nhl
    class Season
      attr_reader :id, :year, :type

      def initialize(json)
        @json = json
        @id = json['season']['id']
        @year = json['season']['year']
        @type = json['season']['type'].to_sym
      end

      def games
        @games ||= json['games'].map do |game_json|
          Game.new(year: year, season: type, json: game_json)
        end
      end

      ##
      # Check if the requested season is a valid
      # NHL season type.
      #
      # The only valid types are: :pre, :reg, :pst
      def self.valid?(season)
        %i[PRE REG PST].include?(season)
      end

      private

      attr_reader :json
    end
  end
end
