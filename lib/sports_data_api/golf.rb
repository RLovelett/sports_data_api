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

    # Fetches Golf tournament schedule for a given tour and year
    def self.season(tour, year, version = DEFAULT_VERSION)
      tour = tour.to_s.downcase.to_sym
      unless Season.valid_tour?(tour)
        raise SportsDataApi::Golf::Exception.new("#{tour} is not a valid tour")
      end

      response = self.response_json(version, "/schedule/#{tour}/#{year}/tournaments/schedule.json")

      return Season.new(response)
    end

    private

    def self.response_json(version, url)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      response = SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
      MultiJson.load(response.to_s)
    end
  end
end
