module SportsDataApi
  module Ncaamb
    extend SportsDataApi::Request

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

    class << self
      ##
      # Fetches NCAAAMB season schedule for a given year and season
      def schedule(year, season)
        season = season.to_s.upcase.to_sym
        raise Error.new("#{season} is not a valid season") unless Season.valid?(season)

        Season.new(response_xml_xpath("/games/#{year}/#{season}/schedule.xml", '/league/season-schedule'))
      end

      # ##
      # # Fetches NCAAMB team roster
      def team_roster(team)
        Team.new(response_xml_xpath("/teams/#{team}/profile.xml", 'team'))
      end

      # ##
      # # Fetches NCAAMB game summary for a given game
      def game_summary(game)
        Game.new(xml: response_xml_xpath("/games/#{game}/summary.xml", '/game'))
      end

      # ##
      # # Fetches all NCAAMB teams
      def teams
        Teams.new(response_xml_xpath('/league/hierarchy.xml', '/league'))
      end

      # ##
      # # Fetches NCAAMB daily schedule for a given date
      def daily(year, month, day)
        Games.new(response_xml_xpath("/games/#{year}/#{month}/#{day}/schedule.xml", 'league/daily-schedule'))
      end

      # Fetches NCAAAMB tournaments for a given year and season
      def tournament_list(year, season)
        season = season.to_s.upcase.to_sym
        raise Error.new("#{season} is not a valid season") unless TournamentList.valid?(season)

        TournamentList.new(response_xml_xpath("/tournaments/#{year}/#{season}/schedule.xml", '/league/season-schedule'))
      end

      def tournament_schedule(year, season, tournament_id)
        raise Error.new("#{season} is not a valid season") unless TournamentSchedule.valid?(season)

        TournamentSchedule.new(year, season, response_xml_xpath("/tournaments/#{tournament_id}/schedule.xml", '/league/tournament-schedule'))
      end
    end
  end
end
