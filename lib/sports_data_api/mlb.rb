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

    class << self
      ##
      # Fetches all NBA teams
      def teams(year = Date.today.year)
        Teams.new(response_xml_xpath("/teams/#{year}.xml", '/teams'))
      end

      ##
      # Fetches MLB season schedule for a given year and season
      def schedule(year = Date.today.year)
        Season.new(response_xml_xpath("/schedule/#{year}.xml", 'calendars'))
      end

      ##
      # Fetches MLB daily schedule for a given date
      def daily(year, month, day)
        Games.new(response_xml_xpath("/daily/schedule/#{year}/#{month}/#{day}.xml", 'calendars'))
      end

      ##
      # Fetches MLB venues
      def venues
        Venues.new(response_xml_xpath('/venues/venues.xml', 'venues'))
      end

      ##
      # Fetch MLB game stats
      def game_statistics(event_id)
        GameStats.new(response_xml_xpath("/statistics/#{event_id}.xml", '/statistics'))
      end

      ##
      # Fetch MLB Game Boxscore
      def game_boxscore(event_id)
        Boxscore.new(response_xml_xpath("/boxscore/#{event_id}.xml", '/boxscore'))
      end

      ##
      # Fetches MLB team roster
      def team_roster(year=Date.today.year)
        Players.new(response_xml_xpath("/rosters-full/#{year}.xml", 'rosters'))
      end
    end
  end
end
