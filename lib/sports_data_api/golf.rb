module SportsDataApi
  module Golf
    extend SportsDataApi::Request

    API_VERSION = 2
    BASE_URL = 'https://api.sportsdatallc.org/golf-%{access_level}%{version}'
    DIR = File.join(File.dirname(__FILE__), 'golf')
    SPORT = :golf

    autoload :Course, File.join(DIR, 'course')
    autoload :Leaderboard, File.join(DIR, 'leaderboard')
    autoload :Pairing, File.join(DIR, 'pairing')
    autoload :Player, File.join(DIR, 'player')
    autoload :Round, File.join(DIR, 'round')
    autoload :Score, File.join(DIR, 'score')
    autoload :Season, File.join(DIR, 'season')
    autoload :Summary, File.join(DIR, 'summary')
    autoload :Tournament, File.join(DIR, 'tournament')

    module UrlPaths
      SEASON       = '/schedule/%{tour}/%{year}/tournaments/schedule.json'.freeze
      PLAYERS      = '/profiles/%{tour}/%{year}/players/profiles.json'.freeze
      SUMMARY      = '/summary/%{tour}/%{year}/tournaments/%{tournament_id}/summary.json'.freeze
      TEE_TIMES    = '/teetimes/%{tour}/%{year}/tournaments/%{tournament_id}/rounds/%{round}/teetimes.json'.freeze
      SCORECARDS   = '/scorecards/%{tour}/%{year}/tournaments/%{tournament_id}/rounds/%{round}/scores.json'.freeze
      LEADERBOARDS = '/leaderboard/%{tour}/%{year}/tournaments/%{tournament_id}/leaderboard.json'.freeze
    end

    class << self
      # Fetches Golf tournament schedule for a given tour and year
      def season(tour, year)
        response = response_json UrlPaths::SEASON % { tour: tour, year: year }

        Season.new(response)
      end

      # Fetch all players for a season
      def players(tour, year)
        response = response_json UrlPaths::PLAYERS % { tour: tour, year: year }

        response['players'].map do |json|
          Player.new(json)
        end
      end

      # Fetch a tournament summary
      def summary(tour, year, tournament_id)
        response = response_json UrlPaths::SUMMARY %
          { tour: tour, year: year, tournament_id: tournament_id }

        Summary.new(tour, year, response)
      end

      # Fetch teetimes for a round in a tournament
      def tee_times(tour, year, tournament_id, round)
        response = response_json UrlPaths::TEE_TIMES %
          { tour: tour, year: year, tournament_id: tournament_id, round: round }


        response['round']['courses'].map do |json|
          Course.new(json)
        end
      end

      # fetches scorecards for a golf round
      def scorecards(tour, year, tournament_id, round)
        response = response_json UrlPaths::SCORECARDS %
          { tour: tour, year: year, tournament_id: tournament_id, round: round }

        {
          round: round,
          tournament_id: tournament_id,
          status: response['round']['status'],
          year: year,
          tour: tour,
          players: response['round']['players'].map do |json|
            Player.new(json)
          end
        }
      end

      # fetches leaderboard for a golf tournament
      def leaderboard(tour, year, tournament_id)
        response = response_json UrlPaths::LEADERBOARDS %
          { tour: tour, year: year, tournament_id: tournament_id }

        response['leaderboard'].map do |json|
          Player.new(json)
        end
      end
    end
  end
end
