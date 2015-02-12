module SportsDataApi
  module Ncaamb
    class Venue
      attr_reader :id, :name, :address, :city, :state, :zip, :country, :capacity
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @address = xml['address']
          @city = xml['city']
          @state = xml['state']
          @zip = xml['zip']
          @country = xml['country']
          @capacity = xml['capacity']
        end
      end
    end
  end
end
