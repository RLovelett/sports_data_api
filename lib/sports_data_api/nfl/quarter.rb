module SportsDataApi
  module Nfl
    class Quarter
      attr_reader :number, :play_by_plays

      def initialize(quarter_hash)
        @number = quarter_hash["number"]
        @play_by_plays = PlayByPlays.new(quarter_hash["pbp"])
      end
    end
  end
end
