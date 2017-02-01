module SportsDataApi
  module Ncaamb

    class Exception < ::Exception
    end

    API_VERSION = 3
    BASE_URL = 'https://api.sportsdatallc.org/ncaamb-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'ncaamb')
    SPORT = :ncaamb

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Season, File.join(DIR, 'season')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Broadcast, File.join(DIR, 'broadcast')
    autoload :TournamentList, File.join(DIR, 'tournament_list')
    autoload :Tournament, File.join(DIR, 'tournament')
    autoload :TournamentSchedule, File.join(DIR, 'tournament_schedule')
    autoload :TournamentGame, File.join(DIR, 'tournament_game')

    ##
    # Fetches NCAAAMB season schedule for a given year and season
    def self.schedule(year, season)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaamb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_xml("/games/#{year}/#{season}/schedule.xml")

      return Season.new(response.xpath("/league/season-schedule"))
    end

    # ##
    # # Fetches NCAAMB team roster
    def self.team_roster(team)
      response = self.response_xml("/teams/#{team}/profile.xml")

      return Team.new(response.xpath("team"))
    end

    # ##
    # # Fetches NCAAMB game summary for a given game
    def self.game_summary(game)
      response = self.response_xml("/games/#{game}/summary.xml")

      return Game.new(xml: response.xpath("/game"))
    end

    # ##
    # # Fetches all NCAAMB teams
    def self.teams
      response = self.response_xml("/league/hierarchy.xml")

      return Teams.new(response.xpath('/league'))
    end

    # ##
    # # Fetches NCAAMB daily schedule for a given date
    def self.daily(year, month, day)
      response = self.response_xml("/games/#{year}/#{month}/#{day}/schedule.xml")

      return Games.new(response.xpath('league/daily-schedule'))
    end

    # Fetches NCAAAMB tournaments for a given year and season
    def self.tournament_list(year, season)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaamb::Exception.new("#{season} is not a valid season") unless TournamentList.valid?(season)

      response = self.response_xml("/tournaments/#{year}/#{season}/schedule.xml")

      return TournamentList.new(response.xpath("/league/season-schedule"))
    end

    def self.tournament_schedule(year, season, tournament_id)
      response = self.response_xml("/tournaments/#{tournament_id}/schedule.xml")
      raise SportsDataApi::Ncaamb::Exception.new("#{season} is not a valid season") unless TournamentSchedule.valid?(season)

      return TournamentSchedule.new(year, season, response.xpath("/league/tournament-schedule"))
    end

    private

    def self.response_xml(url)
      base_url = BASE_URL % {
        access_level: SportsDataApi.access_level(SPORT),
        version: API_VERSION
      }
      response = SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
      Nokogiri::XML(response.to_s).remove_namespaces!
    end
  end
end
