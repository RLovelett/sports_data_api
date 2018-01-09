module SportsDataApi
  module Nba
    class Venue
      attr_reader :id, :name, :address, :city, :state, :zip, :country, :capacity

      def initialize(json)
        @id = json['id']
        @name = json['name']
        @address = json['address']
        @city = json['city']
        @state = json['state']
        @zip = json['zip']
        @country = json['country']
        @capacity = json['capacity']
      end
    end
  end
end
