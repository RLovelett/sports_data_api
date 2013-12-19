module SportsDataApi
  module Nba

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nba')
    BASE_URL = 'http://api.sportsdatallc.org/nba-%{access_level}%{version}'

    autoload :Team, File.join(DIR, 'team')
    autoload :Teams, File.join(DIR, 'teams')
    autoload :Player, File.join(DIR, 'player')
    autoload :Game, File.join(DIR, 'game')
    autoload :Games, File.join(DIR, 'games')
    autoload :Season, File.join(DIR, 'season')
    autoload :Venue, File.join(DIR, 'venue')
    autoload :Broadcast, File.join(DIR, 'broadcast')

    ##
    # Fetches NBA season schedule for a given year and season.
    def self.schedule(year, season, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nba::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/games/#{year}/#{season}/schedule.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      schedule = Nokogiri::XML(response.to_s)
      schedule.remove_namespaces!

      return Season.new(schedule.xpath("/league/season-schedule"))
    end

    ##
    # Fetch NBA Team Roster
    def self.team_roster(team, version=3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/#{team}/profile.xml"

      roster = Nokogiri::XML(self.generic_request(url.to_s)).remove_namespaces!
      return Team.new(roster.xpath("team"))
    end

    ##
    #
    def self.game_summary(game, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/games/#{game}/summary.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      summary = Nokogiri::XML(response.to_s)
      summary.remove_namespaces!

      return Game.new(xml: summary.xpath("/game"))
    end

    ##
    # Fetches all NBA Teams
    def self.teams(version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/league/hierarchy.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      teams = Nokogiri::XML(response.to_s)
      teams.remove_namespaces!

      return Teams.new(teams.xpath('/league'))
    end

    ##
    #
    def self.daily(year, month, day, version = 3)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version}
      url = "#{base_url}/games/#{year}/#{month}/#{day}/schedule.xml"

      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      games = Nokogiri::XML(response.to_s)
      games.remove_namespaces!

      return Games.new(games.xpath('league/daily-schedule'))
    end

    private
    def self.generic_request(url)
      begin
        return RestClient.get(url, params: { api_key: SportsDataApi.key(:nba) })
      rescue RestClient::RequestTimeout => timeout
        raise SportsDataApi::Exception, 'The API did not respond in a reasonable amount of time'
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
