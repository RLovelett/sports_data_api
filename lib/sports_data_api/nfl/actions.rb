module SportsDataApi
  module Nfl
    class Actions
      include Enumerable
      attr_reader :actions

      def initialize(actions)
        @actions = actions.map do |action|
          map_by_type(action)
        end
      end

      def each &block
        actions.each do |action|
          if block_given?
            block.call action
          else
            yield action
          end
        end
      end

      def map_by_type(action)
        case action["type"]
        when "event"
          EventAction.new(action)
        when "play"
          PlayAction.new(action)
        end
      end
    end
  end
end
