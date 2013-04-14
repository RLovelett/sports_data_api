module SportsDataApi
  module Nfl
    class Broadcast
      attr_reader :network, :satellite, :internet
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @network = xml['network']
          @satellite = xml['satellite']
          @internet = xml['internet']
        end
      end
    end
  end
end