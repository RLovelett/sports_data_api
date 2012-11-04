require "sports_data_api/version"
require "nokogiri"
require "rest_client"
require "time"

module SportsDataApi
  def self.key
    @key ||= "garbage"
  end

  def self.key=(new_key)
    @key = new_key
  end

  def self.access_level
    @access_level ||= "t"
  end

  def self.access_level=(new_level)
    @access_level = new_level
  end

  autoload :Nfl, File.join(File.dirname(__FILE__), 'nfl')

  class Exception < ::Exception; end
end
