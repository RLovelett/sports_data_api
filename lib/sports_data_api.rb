require "sports_data_api/version"
require "nokogiri"
require "rest_client"
require "time"
require "json"

module SportsDataApi
  def self.key(sport)
    @key ||= {}
    @key[sport] ||= ''
    @key[sport]
  end

  def self.set_key(sport, new_key)
    @key ||= {}
    @key[sport] = new_key
  end

  def self.access_level(sport)
    @access_level ||= {}
    @access_level[sport] ||= "t"
    @access_level[sport]
  end

  def self.set_access_level(sport, new_level)
    @access_level ||= {}
    @access_level[sport] = new_level
  end

  def self.generic_request(url, sport)
    begin
      return RestClient.get(url, params: { api_key: SportsDataApi.key(sport) })
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

  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'sports_data_api')

  autoload :Stats,       File.join(LIBRARY_PATH, 'stats')
  autoload :Nfl,         File.join(LIBRARY_PATH, 'nfl')
  autoload :Nba,         File.join(LIBRARY_PATH, 'nba')
  autoload :Mlb,         File.join(LIBRARY_PATH, 'mlb')
  autoload :Exception,   File.join(LIBRARY_PATH, 'exception')
end
