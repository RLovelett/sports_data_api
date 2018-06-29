module SportsDataApi
  module Nfl
    class Team
      attr_reader :id, :name, :alias, :market, :statistics,
        :remaining_challenges, :remaining_timeouts

      def initialize(json, conference: nil, division: nil, statistics: nil)
        @json = json
        @conference = conference
        @division = division
        @statistics = statistics

        @id = json['id']
        @name = json['name']
        @alias = json['alias']
        @market = json['market']
        @remaining_challenges = json['remaining_challenges']
        @remaining_timeouts = json['remaining_timeouts']
      end

      def conference
        @conference || json.dig('conference', 'name')
      end

      def division
        @division || json.dig('division', 'name')
      end

      def venue
        return unless json['venue']
        Venue.new(json['venue'])
      end

      def points
        json['points']
      end

      def players
        players_json.map { |p| Player.new(p) }
      end

      private

      PLAYER_KEYS = %w[id name jersey reference position].freeze
      EXTRA_POINTS_KEY = 'extra_points'.freeze

      attr_reader :json

      def players_json
        if statistics
          players_from_stats.values
        else
          json.fetch('players', [])
        end
      end

      def players_from_stats
        statistics.each_with_object({}) do |(key, data), players|
          next unless data.is_a?(Hash)
          if key == EXTRA_POINTS_KEY
            data.each do |nested_key, nested_data|
              nested_data.fetch('players', []).each do |player_json|
                category = player_json.delete('category') || nested_key
                add_stat(players, player_json, "#{key}_#{category}")
              end
            end
          else
            data.fetch('players', []).each do |player_json|
              add_stat(players, player_json, key)
            end
          end
        end
      end

      def add_stat(players, player_json, key)
        base, stats = split_player_json(player_json)
        player = players[player_json['id']] || base
        player['statistics'][key] = stats
        players[player['id']] = player
      end

      def split_player_json(player_json)
        player = { 'statistics' => {} }
        stats = {}
        player_json.each do |k, v|
          hash = PLAYER_KEYS.include?(k) ? player : stats
          hash[k] = v
        end
        [player, stats]
      end
    end
  end
end
