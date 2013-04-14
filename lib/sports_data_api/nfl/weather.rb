module SportsDataApi
  module Nfl
    class Weather
      attr_reader :temperature, :condition, :humidity, :wind_speed, :wind_direction
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @temperature = xml['temperature'].to_i
          @condition = xml['condition']
          @humidity = xml['humidity'].to_i
          @wind_speed = xml.xpath('wind').first['speed'].to_i
          @wind_direction = xml.xpath('wind').first['direction']
        end
      end
    end
  end
end
