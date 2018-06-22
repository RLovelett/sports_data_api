module SportsDataApi
  module Nfl
    class Game
      attr_reader :id, :status, :quarter, :clock

      def initialize(json, year: nil, season: nil, week: nil)
        @json = json
        @year = year
        @season = season
        @week = week

        @id = json['id']
        @status = json['status']
        @quarter = json['quarter']&.to_i
        @clock = json['clock']
      end

      def year
        @year || json.fetch('summary', {}).fetch('season', {})['year']
      end

      def season
        @season || json.fetch('summary', {}).fetch('season', {})['name']&.to_sym
      end

      def week
        @week || json.fetch('summary', {}).fetch('week', {})['sequence']
      end

      def scheduled
        Time.parse(json['scheduled'])
      end

      def home_team_id
        dig_key('home', 'summary')['id']
      end

      def away_team_id
        dig_key('away', 'summary')['id']
      end

      def home_team
        Team.new(
          dig_key('home', 'summary'),
          statistics: json.fetch('statistics', {})['home']
        )
      end

      def away_team
        Team.new(
          dig_key('away', 'summary'),
          statistics: json.fetch('statistics', {})['away']
        )
      end

      def venue
        Venue.new(dig_key('venue', 'summary'))
      end

      def broadcast
        return unless json['broadcast']
        Broadcast.new(json['broadcast'])
      end

      private

      attr_reader :json

      def dig_key(key, secondary)
        json[key] || json.fetch(secondary, {})[key]
      end
    end
  end
end
