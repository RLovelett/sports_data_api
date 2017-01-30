module SportsDataApi
  module Ncaafb
    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'ncaafb')
    BASE_URL = 'http://api.sportsdatallc.org/ncaafb-%{access_level}%{version}'
    DEFAULT_VERSION = 1
    SPORT = :ncaafb

    autoload :Division, File.join(DIR, 'division')
    autoload :PollTeam, File.join(DIR, 'poll_team')
    autoload :Polls, File.join(DIR, 'polls')
    autoload :Team, File.join(DIR, 'team')
    autoload :TeamRoster, File.join(DIR, 'team_roster')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
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
    # Fetches Ncaafb season schedule for a given year and season
    def self.schedule(year, season, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/schedule.json")

      return Season.new(response)
    end

    ##
    # Fetches Ncaafb season ranking for a given year , poll and week
    def self.rankings(year, poll, week, version = DEFAULT_VERSION)
      raise SportsDataApi::Ncaafb::Exception.new("#{poll} is not a valid poll")  unless Polls.valid_name?(poll)
      raise SportsDataApi::Ncaafb::Exception.new("#{week} nr is not a valid week nr") unless Polls.valid_week?(week)

      response = self.response_json(version,  "/polls/#{poll}/#{year}/#{week}/rankings.json")
      return Polls.new(response)
    end

    ##
    # Fetches Ncaafb boxscore for a given game
    def self.boxscore(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/boxscore.json")

      return Game.new(year, season, week, response)
    end

    ##
    # Fetches statistics for a given Ncaafb game
    def self.game_statistics(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/statistics.json")

      return Game.new(year, season, week, response)
    end

    # Fetches Ncaafb roster for a given game
    def self.game_roster(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/#{away}/#{home}/roster.json")

      return Game.new(year, season, week, response)
    end

    ##
    # Fetches all Ncaafb teams
    def self.teams(division, version = DEFAULT_VERSION)
      raise SportsDataApi::Ncaafb::Exception.new("#{division} is not a valid division") unless Division.valid?(division)
      response = self.response_json(version, "/teams/#{division}/hierarchy.json")

      return Teams.new(response)
    end

    # Fetch Ncaafb team roster
    def self.team_roster(team, version = DEFAULT_VERSION)
      response = self.response_json(version, "/teams/#{team}/roster.json")

      return TeamRoster.new(response)
    end

    ##
    # Fetches Ncaafb weekly schedule for a given year, season and week
    def self.weekly(year, season, week, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

      response = self.response_json(version, "/#{year}/#{season}/#{week}/schedule.json")

      return Games.new(year, season, week, response)
    end

    def self.play_by_play(year, season, week, home, away, version = DEFAULT_VERSION)
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Ncaafb::Exception.new("#{season} is not a valid season") unless Season.valid?(season)

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
