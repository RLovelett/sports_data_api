module SportsDataApi
  module Nfl
    class TeamHierarchy
      attr_reader :id, :name, :market

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @market = xml['market']
        end
      end
    end
  end
end
