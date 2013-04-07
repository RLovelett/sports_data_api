module SportsDataApi
  module Nfl

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nfl')
    BASE_URL = 'http://api.sportsdatallc.org/nfl-%{access_level}%{version}'

    autoload :Team,   File.join(DIR, 'team')
    autoload :Game,   File.join(DIR, 'game')
    autoload :Week,   File.join(DIR, 'week')
    autoload :Season, File.join(DIR, 'season')

    ##
    # Fetches NFL season schedule for a given year and season.
    def self.schedule(year, season, version = 1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/#{year}/#{season}/schedule.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      schedule = Nokogiri::XML(response.to_s)
      schedule.remove_namespaces!

      return Season.new(schedule.xpath("/season"))
    end

    ##
    #
    def self.boxscore(year, season, week, home, away, version = 1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/#{year}/#{season}/#{week}/#{away}/#{home}/boxscore.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      boxscore = Nokogiri::XML(response.to_s)
      boxscore.remove_namespaces!

      return Game.new(boxscore.xpath("/game"))
    end

    private
    def self.generic_request(url)
      begin
        return RestClient.get(url, params: { api_key: SportsDataApi.key })
      rescue RestClient::Exception => e
        message = if e.response.headers.key? :x_server_error
                    JSON.parse(e.response.headers[:x_server_error], { symbolize_names: true })[:message]
                  elsif e.response.headers.key? :x_mashery_error_code
                    e.response.headers[:x_mashery_error_code]
                  else
                    "The server did not specify a message"
                  end
        raise SportsDataApi::Exception, message
      end
    end
  end
end
