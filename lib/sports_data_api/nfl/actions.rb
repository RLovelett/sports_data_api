module SportsDataApi
  module Nfl
    class Actions
      class << self
        def build_actions(actions)
          actions.map do |action|
            map_by_type(action)
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
end
