module SportsDataApi
  module Nfl
    extend SportsDataApi::Request

    API_VERSION = 2
    BASE_URL = 'https://api.sportradar.us/nfl-%{access_level}%{version}'.freeze
    SPORT = :nfl
    DIR = File.join(File.dirname(__FILE__), SPORT.to_s)

    autoload :Broadcast, File.join(DIR, 'broadcast')
    autoload :Game, File.join(DIR, 'game')
    autoload :Player, File.join(DIR, 'player')
    autoload :Season, File.join(DIR, 'season')
    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Week, File.join(DIR, 'week')

    class << self
      def schedule(year, season)
        Season.new(response_json("/games/#{year}/#{season}/schedule.json"))
      end

      def team_roster(team_id)
        Team.new(response_json("/teams/#{team_id}/full_roster.json"))
      end

      def boxscore(game_id)
        Game.new(response_json("/games/#{game_id}/boxscore.json"))
      end

      def game_statistics(game_id)
        Game.new(response_json("/games/#{game_id}/statistics.json"))
      end

      def game_roster(game_id)
        Game.new(response_json("/games/#{game_id}/roster.json"))
      end

      def teams
        Teams.new(response_json('/league/hierarchy.json'))
      end
    end
  end
end
