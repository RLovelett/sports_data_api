module SportsDataApi
  module Nfl
    extend SportsDataApi::Request

    class Exception < ::Exception
    end

    API_VERSION = 1
    BASE_URL = 'https://api.sportsdatallc.org/nfl-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'nfl')
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

    class << self
      # Fetches NFL season schedule for a given year and season
      def schedule(year, season)
        response = get("/#{year}/%{season}/schedule.json", season)
        Season.new(response)
      end

      # Fetch NFL team roster
      def team_roster(team)
        response = response_json("/teams/#{team}/roster.json")
        TeamRoster.new(response)
      end

      # Fetch NFL team seaon stats for a given team, season and season type
      def team_season_stats(team, year, season)
        response = get("/teams/#{team}/#{year}/%{season}/statistics.json", season)
        TeamSeasonStats.new(response)
      end

      # Fetch NFL player seaon stats for a given team, season and season type
      def player_season_stats(team, year, season)
        response = get("/teams/#{team}/#{year}/%{season}/statistics.json", season)
        PlayerSeasonStats.new(response)
      end

      # Fetches NFL boxscore for a given game
      def boxscore(year, season, week, home, away)
        response = get("/#{year}/%{season}/#{week}/#{away}/#{home}/boxscore.json", season)
        Game.new(year, season, week, response)
      end

      # Fetches statistics for a given NFL game
      def game_statistics(year, season, week, home, away)
        response = get("/#{year}/%{season}/#{week}/#{away}/#{home}/statistics.json", season)
        Game.new(year, season, week, response)
      end

      # Fetches roster for a given NFL game
      def game_roster(year, season, week, home, away)
        response = get("/#{year}/%{season}/#{week}/#{away}/#{home}/roster.json", season)
        Game.new(year, season, week, response)
      end

      # Fetches all NFL teams
      def teams
        Teams.new(response_json('/teams/hierarchy.json'))
      end

      # Fetches NFL weekly schedule for a given year, season and week
      def weekly(year, season, week)
        response = get("/#{year}/%{season}/#{week}/schedule.json", season)
        Games.new(year, season, week, response)
      end

      # Fetches NFL play by play for a given year, season and week
      def play_by_play(year, season, week, home, away)
        response = get("/#{year}/%{season}/#{week}/#{away}/#{home}/pbp.json", season)
        PlayByPlay.new(year, season, week, response)
      end

      private

      def get(path, season)
        season = validate_season(season)
        response_json(path % { season: season })
      end

      def validate_season(param)
        param.to_s.upcase.to_sym.tap do |season|
          unless Season.valid?(season)
            raise Exception.new("#{season} is not a valid season")
          end
        end
      end
    end
  end
end
