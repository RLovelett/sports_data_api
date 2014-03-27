module SportsDataApi
  module Mlb
    class Games
      include Enumerable
      attr_reader :games, :year

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

      def each &block
        @games.each do |game|
          if block_given?
            block.call game
          else
            yield game
          end
        end
      end
    end
  end
end
