module SportsDataApi
  module Nfl
    class Drive
      attr_reader :id, :clock, :type, :team, :actions

      def initialize(event_hash)
        @id = event_hash["id"]
        @clock = event_hash["clock"]
        @type = event_hash["type"]
        @team= event_hash["team"]
        @actions = Actions.new(event_hash["actions"])
      end
    end
  end
end
