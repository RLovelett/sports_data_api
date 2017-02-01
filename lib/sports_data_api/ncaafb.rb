module SportsDataApi
  module Ncaafb
    extend SportsDataApi::Request

    class Exception < ::Exception
    end

    API_VERSION = 1
    BASE_URL = 'https://api.sportsdatallc.org/ncaafb-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'ncaafb')
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

    class << self
      # Fetches Ncaafb season schedule for a given year and season
      def schedule(year, season)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/schedule.json")

        Season.new(response)
      end

      # Fetches Ncaafb season ranking for a given year , poll and week
      def rankings(year, poll, week)
        raise Exception.new("#{poll} is not a valid poll")  unless Polls.valid_name?(poll)
        raise Exception.new("#{week} nr is not a valid week nr") unless Polls.valid_week?(week)

        response = response_json("/polls/#{poll}/#{year}/#{week}/rankings.json")
        Polls.new(response)
      end

      # Fetches Ncaafb boxscore for a given game
      def boxscore(year, season, week, home, away)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/#{week}/#{away}/#{home}/boxscore.json")

        Game.new(year, season, week, response)
      end

      # Fetches statistics for a given Ncaafb game
      def game_statistics(year, season, week, home, away)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/#{week}/#{away}/#{home}/statistics.json")

        Game.new(year, season, week, response)
      end

      # Fetches Ncaafb roster for a given game
      def game_roster(year, season, week, home, away)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/#{week}/#{away}/#{home}/roster.json")

        Game.new(year, season, week, response)
      end

      # Fetches all Ncaafb teams
      def teams(division)
        raise Exception.new("#{division} is not a valid division") unless Division.valid?(division)
        response = response_json("/teams/#{division}/hierarchy.json")

        Teams.new(response)
      end

      # Fetch Ncaafb team roster
      def team_roster(team)
        response = response_json("/teams/#{team}/roster.json")

        TeamRoster.new(response)
      end

      # Fetches Ncaafb weekly schedule for a given year, season and week
      def weekly(year, season, week)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/#{week}/schedule.json")

        Games.new(year, season, week, response)
      end

      def play_by_play(year, season, week, home, away)
        season = validate_season(season)
        response = response_json("/#{year}/#{season}/#{week}/#{away}/#{home}/pbp.json")

        PlayByPlay.new(year, season, week, response)
      end

      private

      def validate_season(param)
        param.to_s.upcase.to_sym.tap do |season|
          unless Season.valid?(season)
            raise Exception.new("#{season} is not a valid season") unless Season.valid?(season)
          end
        end
      end
    end
  end
end
