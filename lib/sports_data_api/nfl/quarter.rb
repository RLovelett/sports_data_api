module SportsDataApi
  module Nfl
    class Quarter
      attr_reader :number, :pbps

      def initialize(quarter_hash)
        @number = quarter_hash["number"]
        @pbps = Pbps.new(quarter_hash["pbp"])
      end
    end
  end
end
