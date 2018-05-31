module SportsDataApi
  module Nhl
    extend SportsDataApi::Request

    API_VERSION = 5
    BASE_URL = 'https://api.sportradar.us/nhl/%{access_level}/v%{version}/en'
    DIR = File.join(File.dirname(__FILE__), 'nhl')
    SPORT = :nhl

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Season, File.join(DIR, 'season')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Broadcast, File.join(DIR, 'broadcast')

    class << self
      ##
      # Fetches NHL season schedule for a given year and season
      def schedule(year, season)
        season = season.to_s.upcase.to_sym
        raise Error.new("#{season} is not a valid season") unless Season.valid?(season)

        Season.new(response_json("/games/#{year}/#{season}/schedule.json"))
      end

      ##
      # Fetches NHL team roster
      def team_roster(team_id)
        Team.new(response_json("/teams/#{team_id}/profile.json"))
      end

      ##
      # Fetches NHL game summary for a given game
      def game_summary(game_id)
        Game.new(json: response_json("/games/#{game_id}/summary.json"))
      end

      ##
      # Fetches all NHL teams
      def teams
        Teams.new(response_json('/league/hierarchy.json'))
      end

      ##
      # Fetches NHL daily schedule for a given date
      def daily(year, month, day)
        Games.new(response_json("/games/#{year}/#{month}/#{day}/schedule.json"))
      end
    end
  end
end
