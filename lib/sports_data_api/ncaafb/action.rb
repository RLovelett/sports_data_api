module SportsDataApi
  module Ncaafb
    class EventAction
      attr_reader :id, :sequence, :clock, :type, :summary, :updated, :event_type

      def initialize(quarter_hash)
        @id = quarter_hash["id"]
        @sequence = quarter_hash["sequence"]
        @clock = quarter_hash["clock"]
        @type = quarter_hash["type"]
        @summary = quarter_hash["summary"]
        @updated = quarter_hash["updated"]
        @event_type = quarter_hash["event_type"]
      end
    end
  end
end
