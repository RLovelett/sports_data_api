module SportsDataApi
  module Mlb
    class Venues
      include Enumerable

      def initialize(xml)
        @venues = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        xml.children.each do |venue|
          next unless venue.is_a? Nokogiri::XML::Element
          @venues << Venue.new(venue)
        end
        @venues
      end

      def [](search_index)
        found_index = @venues.index(search_index)
        unless found_index.nil?
          @venues[found_index]
        end
      end

      ##
      # Make the class Enumerable
      def each(&block)
        @venues.each do |venue|
          if block_given?
            block.call venue
          else
            yield venue
          end
        end
      end
    end
  end
end

