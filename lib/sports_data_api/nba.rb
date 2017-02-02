module SportsDataApi
  module Nba
    extend SportsDataApi::Request

    class Exception < ::Exception
    end

    API_VERSION = 3
    BASE_URL = 'https://api.sportsdatallc.org/nba-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'nba')
    SPORT = :nba

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
      # Fetches NBA season schedule for a given year and season
      def schedule(year, season)
        season = season.to_s.upcase.to_sym
        raise Exception.new("#{season} is not a valid season") unless Season.valid?(season)

        Season.new(response_xml_xpath("/games/#{year}/#{season}/schedule.xml", "/league/season-schedule"))
      end

      ##
      # Fetches NBA team roster
      def team_roster(team)
        Team.new(response_xml_xpath("/teams/#{team}/profile.xml", 'team'))
      end

      ##
      # Fetches NBA game summary for a given game
      def game_summary(game)
        Game.new(xml: response_xml_xpath("/games/#{game}/summary.xml", '/game'))
      end

      ##
      # Fetches all NBA teams
      def teams
        Teams.new(response_xml_xpath('/league/hierarchy.xml', '/league'))
      end

      ##
      # Fetches NBA daily schedule for a given date
      def daily(year, month, day)
        Games.new(response_xml_xpath("/games/#{year}/#{month}/#{day}/schedule.xml", 'league/daily-schedule'))
      end
    end
  end
end
