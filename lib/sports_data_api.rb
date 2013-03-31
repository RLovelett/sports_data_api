require "sports_data_api/version"
require "nokogiri"
require "rest_client"
require "time"

module SportsDataApi
  def self.key
    @key ||= ''
    @key
  end

  def self.key=(new_key)
    @key = new_key
  end

  def self.access_level
    @access_level ||= "t"
    @access_level
  end

  def self.access_level=(new_level)
    @access_level = new_level
  end

  LIBRARY_PATH = File.join(File.dirname(__FILE__), 'sports_data_api')

  autoload :Nfl,       File.join(LIBRARY_PATH, 'nfl')
  autoload :Exception, File.join(LIBRARY_PATH, 'exception')
end
