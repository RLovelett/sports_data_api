module SportsDataApi
  module Nfl

    class Exception < ::Exception
    end

    class Season
      attr_reader :year, :type, :weeks

      def initialize(xml)
        @weeks = []
        if xml.is_a? Nokogiri::XML::NodeSet
          @year = xml.first["season"].to_i
          @type = xml.first["type"].to_sym
          @weeks = xml.first.xpath("week").map do |week_xml|
            Week.new(week_xml)
          end
        end
      end
    end

    class Week
      attr_reader :number, :games

      def initialize(xml)
        @games = []
        if xml.is_a? Nokogiri::XML::Element
          @number = xml["week"].to_i
          @games = xml.xpath("game").map do |game_xml|
            Game.new(game_xml)
          end
        end
      end
    end

    class Game
      attr_reader :id, :scheduled, :home, :away, :status

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml["id"]
          @scheduled = Time.parse xml["scheduled"]
          @home = xml["home"]
          @away = xml["away"]
          @status = xml["status"]
        end
      end
    end

    BASE_URL = "http://api.sportsdatallc.org/nfl-%{access_level}%{version}"
    SEASONS = [:PRE, :REG, :PST]

    def self.schedule(year, season, version = 1)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level, version: version }
      season = season.to_s.upcase.to_sym
      raise SportsDataApi::Nfl::Exception.new("#{season} is not a valid season") unless season?(season)
      url = "#{base_url}/#{year}/#{season}/schedule.xml"

      begin
        # Perform the request
        response = RestClient.get(url, params: { api_key: SportsDataApi.key })

        # Load the XML and ignore namespaces in Nokogiri
        schedule = Nokogiri::XML(response.to_s)
        schedule.remove_namespaces!

        return Season.new(schedule.xpath("/season"))
      rescue RestClient::Exception => e
        message = if e.response.headers.key? :x_server_error
                    JSON.parse(error_json, { symbolize_names: true })[:message]
                  elsif e.response.headers.key? :x_mashery_error_code
                    e.response.headers[:x_mashery_error_code]
                  else
                    "The server did not specify a message"
                  end
        raise SportsDataApi::Exception, message
      end
    end

    ##
    # Check if the requested season is a valid
    # NFL season type.
    #
    # The only valid types are: :PRE, :REG, :PST
    def self.season?(season)
      SEASONS.include?(season)
    end

  end
end
