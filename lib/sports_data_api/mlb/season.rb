module SportsDataApi
  module Mlb
    class Season
      attr_reader :year, :games

      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        @year = xml['season_year']
        @games = []
        if xml.is_a? Nokogiri::XML::Element
          xml.xpath('event').each do |event|
            @games << Game.new(year: @year, xml: event)
          end
        end
      end
    end
  end
end
