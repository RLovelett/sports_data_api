module SportsDataApi
  module Golf

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'golf')
    BASE_URL = 'https://api.sportsdatallc.org/golf-%{access_level}%{version}'
    DEFAULT_VERSION = 2
    SPORT = :golf

    autoload :Season, File.join(DIR, 'season')
    autoload :Tournament, File.join(DIR, 'tournament')
    autoload :Player, File.join(DIR, 'player')
    autoload :Summary, File.join(DIR, 'summary')
    autoload :Round, File.join(DIR, 'round')
    autoload :Course, File.join(DIR, 'course')
    autoload :Pairing, File.join(DIR, 'pairing')
    autoload :Score, File.join(DIR, 'score')

    class << self
      # Fetches Golf tournament schedule for a given tour and year
      def season(tour, year, version = DEFAULT_VERSION)
        tour = validate_tour(tour)

        response = response_json(version, "/schedule/#{tour}/#{year}/tournaments/schedule.json")

        Season.new(response)
      end

      # Fetch all players for a season
      def players(tour, year, version = DEFAULT_VERSION)
        tour = validate_tour(tour)

        response = response_json(version, "/profiles/#{tour}/#{year}/players/profiles.json")

        return response['players'].map { |player_hash| Player.new(player_hash) }
      end

      # Fetch a tournament summary
      def summary(tour, year, tournament_id, version = DEFAULT_VERSION)
        tour = validate_tour(tour)

        response = response_json(version, "/summary/#{tour}/#{year}/tournaments/#{tournament_id}/summary.json")

        Summary.new(tour, year, response)
      end

      # Fetch teetimes for a round in a tournament
      def tee_times(tour, year, tournament_id, round, version = DEFAULT_VERSION)
        tour = validate_tour(tour)

        response = response_json(version, "/teetimes/#{tour}/#{year}/tournaments/#{tournament_id}/rounds/#{round}/teetimes.json")

        response['round']['courses'].map do |json|
          Course.new(json)
        end
      end

      # fetches scorecards for a golf round
      def scorecards(tour, year, tournament_id, round, version = DEFAULT_VERSION)
        tour = validate_tour(tour)

        response = response_json(version, "/scorecards/#{tour}/#{year}/tournaments/#{tournament_id}/rounds/#{round}/scores.json")

        response['round']['players'].map do |json|
          Player.new(json)
        end
      end

      private

      def response_json(version, url)
        base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
        response = SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
        MultiJson.load(response.to_s)
      end

      def validate_tour(tour)
        tour.to_s.downcase.to_sym.tap do |tour_sym|
          unless Season.valid_tour?(tour_sym)
            raise SportsDataApi::Golf::Exception.new("#{tour_sym} is not a valid tour")
          end
        end
      end
    end
  end
end
