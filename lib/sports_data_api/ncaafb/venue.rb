module SportsDataApi
  module Ncaafb
    class Venue
      attr_reader :id, :name, :address, :city, :state, :zip, :country, :capacity, :type, :surface
      def initialize(venue_hash)
        if venue_hash
          @id = venue_hash['id']
          @name = venue_hash['name']
          @address = venue_hash['address']
          @city = venue_hash['city']
          @state = venue_hash['state']
          @zip = venue_hash['zip']
          @country = venue_hash['country']
          @capacity = venue_hash['capacity']
          @type = venue_hash['type']
          @surface = venue_hash['surface']
        end
      end
    end
  end
end
