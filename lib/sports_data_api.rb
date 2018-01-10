require 'multi_json'
require 'nokogiri'
require 'rest_client'
require 'sports_data_api/request'
require 'sports_data_api/version'
require 'time'

module SportsDataApi
  class << self
    def key(sport)
      @key ||= {}
      @key[sport] ||= ''
      @key[sport]
    end

    def set_key(sport, new_key)
      @key ||= {}
      @key[sport] = new_key
    end

    def access_level(sport)
      @access_level ||= {}
      @access_level[sport] ||= 't'
      @access_level[sport]
    end

    def set_access_level(sport, new_level)
      @access_level ||= {}
      @access_level[sport] = new_level
    end

    def generic_request(url, sport)
      begin
        RestClient.get(url, params: { api_key: SportsDataApi.key(sport) })
      rescue RestClient::RequestTimeout
        raise Exception, 'The API did not respond in a reasonable amount of time'
      rescue RestClient::Exception => e
        raise Exception, exception_message(e)
      end
    end

    private

    def exception_message(e)
      if e.response.headers.key? :x_server_error
        JSON.parse(e.response.headers[:x_server_error])['message']
      elsif e.response.headers.key? :x_mashery_error_code
        e.response.headers[:x_mashery_error_code]
      else
        'The server did not specify a message'
      end
    end
  end

  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'sports_data_api')

  autoload :Exception,   File.join(LIBRARY_PATH, 'exception')
  autoload :Golf,        File.join(LIBRARY_PATH, 'golf')
  autoload :JsonData,    File.join(LIBRARY_PATH, 'json_data')
  autoload :MergedStats, File.join(LIBRARY_PATH, 'merged_stats')
  autoload :Mlb,         File.join(LIBRARY_PATH, 'mlb')
  autoload :Nba,         File.join(LIBRARY_PATH, 'nba')
  autoload :Ncaafb,      File.join(LIBRARY_PATH, 'ncaafb')
  autoload :Ncaamb,      File.join(LIBRARY_PATH, 'ncaamb')
  autoload :Nfl,         File.join(LIBRARY_PATH, 'nfl')
  autoload :Nhl,         File.join(LIBRARY_PATH, 'nhl')
  autoload :Stats,       File.join(LIBRARY_PATH, 'stats')
end
