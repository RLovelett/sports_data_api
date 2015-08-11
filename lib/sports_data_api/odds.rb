module SportsDataApi
  module Odds
    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'odds')
    BASE_URL = 'https://api.sportsdatallc.org/odds-%{access_level}%{version}'
    DEFAULT_VERSION = 1
    SPORT = :odds

    autoload :Game, File.join(DIR, 'game')

    ##
    # Fetches Ncaafb season schedule for a given year and season
    def self.odds
      response = self.response_xml(DEFAULT_VERSION)
      response.css('Date').map do |date|
        OpenStruct.new({
          date: date.css('GameDate').text,
          nfl: date.css('NFL Game').map {|g| Odds::Game.load_from_xml(g, date.css('GameDate').text)},
          nba: date.css('NBA Game').map {|g| Odds::Game.load_from_xml(g, date.css('GameDate').text)},
          nhl: date.css('NHL Game').map {|g| Odds::Game.load_from_xml(g, date.css('GameDate').text)},
          mlb: date.css('MLB Game').map {|g| Odds::Game.load_from_xml(g, date.css('GameDate').text)}
        })
      end
      
    end

    # private

    def self.response_xml(version)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      response = SportsDataApi.generic_request("#{base_url}", SPORT)
      Nokogiri::XML(response.to_s).remove_namespaces!
    end
  end
end
