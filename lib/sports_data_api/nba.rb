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

    ##
    # Fetches NBA season schedule for a given year and season
    def self.schedule(year, season)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nba::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_xml("/games/#{year}/#{season}/schedule.xml")

      return Season.new(response.xpath("/league/season-schedule"))
    end

    ##
    # Fetches NBA team roster
    def self.team_roster(team)
      response = self.response_xml("/teams/#{team}/profile.xml")

      return Team.new(response.xpath("team"))
    end

    ##
    # Fetches NBA game summary for a given game
    def self.game_summary(game)
      response = self.response_xml("/games/#{game}/summary.xml")

      return Game.new(xml: response.xpath("/game"))
    end

    ##
    # Fetches all NBA teams
    def self.teams
      response = self.response_xml("/league/hierarchy.xml")

      return Teams.new(response.xpath('/league'))
    end

    ##
    # Fetches NBA daily schedule for a given date
    def self.daily(year, month, day)
      response = self.response_xml("/games/#{year}/#{month}/#{day}/schedule.xml")

      return Games.new(response.xpath('league/daily-schedule'))
    end
  end
end
