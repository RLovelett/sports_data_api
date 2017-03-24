module SportsDataApi
  module Mlb
    extend SportsDataApi::Request

    class Exception < ::Exception
    end

    API_VERSION = 6
    BASE_URL = 'https://api.sportradar.us/mlb-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'mlb')
    SPORT = :mlb

    autoload :Division, File.join(DIR, 'division')
    autoload :Game, File.join(DIR, 'game')
    autoload :League, File.join(DIR, 'league')
    autoload :MergedStats, File.join(DIR, 'merged_stats')
    autoload :Player, File.join(DIR, 'player')
    autoload :Scoring, File.join(DIR, 'scoring')
    autoload :Statistics, File.join(DIR, 'statistics')
    autoload :Team, File.join(DIR, 'team')

    class << self
      ##
      # Fetches leagues hierachy
      def leagues
        response = response_json('/league/hierarchy.json')
        map_model response, 'leagues', League
      end

      ##
      # Fetches all MLB teams
      def teams
        leagues.flat_map(&:teams)
      end

      ##
      # Fetches MLB season schedule for a given year and season
      def season_schedule(year, season)
        response = response_json("/games/#{year}/#{season}/schedule.json")
        map_model response, 'games', Game
      end

      ##
      # Fetches MLB daily schedule for a given date
      def daily_schedule(year, month, day)
        response = response_json("/games/#{year}/#{month}/#{day}/schedule.json")
        map_model response, 'games', Game
      end

      ##
      # Fetches MLB daily summary
      def daily_summary(year, month, day)
        response = response_json("/games/#{year}/#{month}/#{day}/summary.json")
        map_model response['league'], 'games', Game, 'game'
      end

      ##
      # Fetches MLB game summary
      def game(game_id)
        response = response_json("/games/#{game_id}/summary.json")
        Game.new(response['game'])
      end

      ##
      # Fetches MLB team roster
      def team(team_id)
        Team.new(response_json("/teams/#{team_id}/profile.json"))
      end

      private

      def map_model(json, key, klass, data_key = nil)
        json[key].map do |data|
          klass.new(data_key ? data[data_key] : data)
        end
      end
    end
  end
end
