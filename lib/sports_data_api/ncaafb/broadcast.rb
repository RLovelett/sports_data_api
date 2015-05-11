module SportsDataApi
  module Ncaafb
    class Broadcast
      attr_reader :network, :satellite, :internet
      def initialize(broadcast_hash)
        if broadcast_hash
          @network = broadcast_hash['network']
          @satellite = broadcast_hash['satellite'] || ''
          @internet = broadcast_hash['internet']
        end
      end
    end
  end
end
