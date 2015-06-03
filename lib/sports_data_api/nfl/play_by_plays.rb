module SportsDataApi
  module Nfl
    class PlayByPlays
      include Enumerable
      attr_reader :events

      def initialize(pbp_events)
        @events = pbp_events.map do |pbp_event|
          if pbp_event["type"] == "event"
            Event.new(pbp_event)
          elsif pbp_event["type"] == "drive"
            Drive.new(pbp_event)
          end
        end
      end

      def each &block
        @events.each do |event|
          if block_given?
            block.call event
          else
            yield event
          end
        end
      end
    end
  end
end
