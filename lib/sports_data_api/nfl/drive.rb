module SportsDataApi
  module Nfl
    class Drive
      attr_reader :id, :clock, :type, :team, :actions

      def initialize(event_hash)
        @id = event_hash["id"]
        @clock = event_hash["clock"]
        @type = event_hash["type"]
        @team= event_hash["team"]
        @actions = Actions.build_actions(event_hash["actions"])
      end

      def play_actions
        actions.select {|i| i.class == SportsDataApi::Nfl::PlayAction}
      end

      def event_actions
        actions.select {|i| i.class == SportsDataApi::Nfl::EventAction }
      end
    end
  end
end
