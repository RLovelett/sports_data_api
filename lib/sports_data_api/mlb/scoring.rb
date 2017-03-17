module SportsDataApi
  module Mlb
    class Scoring
      attr_reader :scoring

      def initialize(scoring)
        @scoring = scoring
      end

      def inning
        @inning ||= last_inning ? last_inning['number'] : nil
      end

      def inning_half
        return unless last_inning

        @inning_half ||= last_inning['runs'] == 'X' ? 'top' : 'bot'
      end

      private

      def last_inning
        @last_inning ||= (scoring || []).sort_by { |i| i['number'] }.last
      end
    end
  end
end
