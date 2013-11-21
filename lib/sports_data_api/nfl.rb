module SportsDataApi
  module Nfl

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nfl')
    BASE_URL = 'http://api.sportsdatallc.org/nfl-%{access_level}%{version}'

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
    # Fetch NFL Team Roster
    def self.team_roster(team, version=1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/#{team}/roster.xml"

      response = Nokogiri::XML(self.generic_request(url.to_s)).remove_namespaces!
      return TeamRoster.new(response.xpath("team"))
    end

    ##
    # Fetch NFL Team Seaon Stats
    def self.team_season_stats(team, season, season_type, version=1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/#{team}/#{season}/#{season_type}/statistics.xml"

      response = Nokogiri::XML(self.generic_request(url.to_s)).remove_namespaces!
      return TeamSeasonStats.new(response.xpath("/season").xpath("team"))
    end

    ##
    # Fetch NFL Player Seaon Stats
    def self.player_season_stats(team, season, season_type, version=1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/#{team}/#{season}/#{season_type}/statistics.xml"

      response = Nokogiri::XML(self.generic_request(url.to_s)).remove_namespaces!
      return PlayerSeasonStats.new(response.xpath("/season").xpath("team").xpath("players"))
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

      return Game.new(year, season, week, boxscore.xpath("/game"))
    end

    ##
    # Fetches all NFL Teams
    def self.teams(version = 1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      url = "#{base_url}/teams/hierarchy.xml"

      # Perform the request
      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      teams = Nokogiri::XML(response.to_s)
      teams.remove_namespaces!

      return Teams.new(teams.xpath('/league'))
    end

    ##
    #
    def self.weekly(year, season, week, version = 1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version}
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless Season.valid?(season)
      url = "#{base_url}/#{year}/#{season}/#{week}/schedule.xml"

      response = self.generic_request(url)

      # Load the XML and ignore namespaces in Nokogiri
      games = Nokogiri::XML(response.to_s)
      games.remove_namespaces!

      return Games.new(games.xpath('/games'))
    end

    private
    def self.generic_request(url)
      begin
        return RestClient.get(url, params: { api_key: SportsDataApi.key })
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
