require "sports_data_api/version"
require "nokogiri"
require "rest_client"
require "time"

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

  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'sports_data_api')

  autoload :Stats,       File.join(LIBRARY_PATH, 'stats')
  autoload :Nfl,         File.join(LIBRARY_PATH, 'nfl')
  autoload :Nba,         File.join(LIBRARY_PATH, 'nba')
  autoload :Exception,   File.join(LIBRARY_PATH, 'exception')
end
