module SportsDataApi
  module Nfl

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nfl')
    BASE_URL = 'http://api.sportsdatallc.org/nfl-%{access_level}%{version}'
    DEFAULT_VERSION = 1
    SPORT = :nfl

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :TeamRoster, File.join(DIR, 'team_roster')
    autoload :Player, File.join(DIR, 'player')
    autoload :TeamSeasonStats, File.join(DIR, 'team_season_stats')
    autoload :PlayerSeasonStats, File.join(DIR, 'player_season_stats')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Week, File.join(DIR, 'week')
    autoload :Season, File.join(DIR, 'season')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Broadcast, File.join(DIR, 'broadcast')
    autoload :Weather, File.join(DIR, 'weather')
    autoload :PlayByPlay, File.join(DIR, 'play_by_play')
    autoload :Quarters, File.join(DIR, 'quarters')
    autoload :Quarter, File.join(DIR, 'quarter')
    autoload :PlayByPlays, File.join(DIR, 'play_by_plays')
    autoload :Drive, File.join(DIR, 'drive')
    autoload :Event, File.join(DIR, 'event')
    autoload :Actions, File.join(DIR, 'actions')
    autoload :EventAction, File.join(DIR, 'play_action')
    autoload :PlayAction, File.join(DIR, 'event_action')

    ##
    # Fetches NFL season schedule for a given year and season
    def self.schedule(year, season, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/schedule.json")

      return Season.new(response)
    end

    ##
    # Fetch NFL team roster
    def self.team_roster(team, version = DEFAULT_VERSION)
      response = self.response_json(version, "/teams/#{team}/roster.json")

      return TeamRoster.new(response)
    end

    ##
    # Fetch NFL team seaon stats for a given team, season and season type
    def self.team_season_stats(team, season, season_type, version = DEFAULT_VERSION)
      response = self.response_json(version, "/teams/#{team}/#{season}/#{season_type}/statistics.json")

      return TeamSeasonStats.new(response)
    end

    ##
    # Fetch NFL player seaon stats for a given team, season and season type
    def self.player_season_stats(team, season, season_type, version = DEFAULT_VERSION)
      response = self.response_json(version, "/teams/#{team}/#{season}/#{season_type}/statistics.json")

      return PlayerSeasonStats.new(response)
    end

    ##
    # Fetches NFL boxscore for a given game
    def self.boxscore(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/boxscore.json")

      return Game.new(year, season, week, response)
    end

    ##
    # Fetches statistics for a given NFL game
    def self.game_statistics(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/statistics.json")

      return Game.new(year, season, week, response)
    end

    # Fetches roster for a given NFL game
    def self.game_roster(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/roster.json")

      return Game.new(year, season, week, response)
    end

    ##
    # Fetches all NFL teams
    def self.teams(version = DEFAULT_VERSION)
      response = self.response_json(version, "/teams/hierarchy.json")

      return Teams.new(response)
    end

    ##
    # Fetches NFL weekly schedule for a given year, season and week
    def self.weekly(year, season, week, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/schedule.json")

      return Games.new(year, season, week, response)
    end

    ##
    # Fetches NFL play by play for a given year, season and week
    def self.play_by_play(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/pbp.json")

      return PlayByPlay.new(year, season, week, response)
    end

    private

    def self.response_json(version, url)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      response = SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
      MultiJson.load(response.to_s)
    end
  end
end
