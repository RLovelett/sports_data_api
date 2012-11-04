require "sports_data_api/version"
require "nokogiri"
require "rest_client"
require "time"

module SportsDataApi
  def self.key
    "garbage"
  end

  def self.access_level
    "t"
  end

  autoload :Nfl, File.join(File.dirname(__FILE__), 'nfl')

  class Exception < ::Exception; end
end
