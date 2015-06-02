module SportsDataApi
  module Nfl
    class Event
      attr_reader :id, :sequence, :clock, :type, :updated, :summary, :winner, :event_type

      def initialize(event_hash)
        @id = event_hash["id"]
        @sequence = event_hash["sequence"]
        @clock = event_hash["clock"]
        @type = event_hash["type"]
        @updated = event_hash["updated"]
        @summary = event_hash["summary"]
        @winner = event_hash["winner"]
        @event_type = event_hash["event_type"]
      end
    end
  end
end
