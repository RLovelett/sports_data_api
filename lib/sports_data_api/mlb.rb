module SportsDataApi
  module Mlb
    extend SportsDataApi::Request

    class Exception < ::Exception
    end

    API_VERSION = 4
    BASE_URL = 'https://api.sportsdatallc.org/mlb-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'mlb')
    SPORT = :mlb

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
    autoload :Players, File.join(DIR, 'players')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Season, File.join(DIR, 'season')
    autoload :Broadcast, File.join(DIR, 'broadcast')
    autoload :GameStat, File.join(DIR,'game_stat')
    autoload :GameStats, File.join(DIR, 'game_stats')
    autoload :Boxscore, File.join(DIR, 'boxscore')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Venues, File.join(DIR, 'venues')

    ##
    # Fetches all NBA teams
    def self.teams(year=Date.today.year)
      response = self.response_xml("/teams/#{year}.xml")
      return Teams.new(response.xpath('/teams'))
    end

    ##
    # Fetches MLB season schedule for a given year and season
    def self.schedule(year=Date.today.year)
      response = self.response_xml("/schedule/#{year}.xml")
      return Season.new(response.xpath("calendars"))
    end

    ##
    # Fetches MLB daily schedule for a given date
    def self.daily(year, month, day)
      response = self.response_xml("/daily/schedule/#{year}/#{month}/#{day}.xml")
      return Games.new(response.xpath("calendars"))
    end

    ##
    # Fetches MLB venues
    def self.venues
      response = self.response_xml("/venues/venues.xml")
      return Venues.new(response.xpath("venues"))
    end

    ##
    # Fetch MLB game stats
    def self.game_statistics(event_id)
      response = self.response_xml("/statistics/#{event_id}.xml")
      return GameStats.new(response.xpath("/statistics"))
    end

    ##
    # Fetch MLB Game Boxscore
    def self.game_boxscore(event_id)
      response = self.response_xml("/boxscore/#{event_id}.xml")
      return Boxscore.new(response.xpath("/boxscore"))
    end

    ##
    # Fetches MLB team roster
    def self.team_roster(year=Date.today.year)
      response = self.response_xml("/rosters-full/#{year}.xml")
      return Players.new(response.xpath("rosters"))
    end
  end
end
