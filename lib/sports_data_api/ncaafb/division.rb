module SportsDataApi
  module Ncaafb
    class Division
      ##
      # Check if the requested division is a valid
      # Ncaafb division type.
      #
      # The only valid types are: :FBS,:FCS, :D2, :D3, :NAIA, :USCAA
      def self.valid?(division)
        [:FBS,:FCS, :D2, :D3, :NAIA, :USCAA].include?(division.upcase.to_sym)
      end
    end
  end
end
