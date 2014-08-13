module SportsDataApi
  module Nfl
    class Season
      attr_reader :year, :type, :weeks

      def initialize(season_hash)
        @weeks = []
        @year = season_hash['season']
        @type = season_hash['type'].to_sym
        @weeks = season_hash['weeks'].map do |week_hash|
          Week.new(@year, @type, week_hash)
        end
      end

      ##
      # Check if the requested season is a valid
      # NFL season type.
      #
      # The only valid types are: :PRE, :REG, :PST
      def self.valid?(season)
        [:PRE, :REG, :PST].include?(season)
      end
    end
  end
end
