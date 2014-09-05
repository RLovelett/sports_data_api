module SportsDataApi
  module Nhl
    class Broadcast
      attr_reader :network, :satellite
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @network = xml['network']
          @satellite = xml['satellite']
        end
      end
    end
  end
end
