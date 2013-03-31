module SportsDataApi
  module Nfl
    class Team
      attr_reader :id, :name, :market, :remaining_challenges, :remaining_timeouts, :score, :quarters

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @market = xml['market']
          @remaining_challenges = xml['remaining_challenges'].to_i
          @remaining_timeouts = xml['remaining_timeouts'].to_i
          @quarters = xml.xpath('scoring/quarter').map do |quarter|
            quarter['points'].to_i
          end
          @quarters = @quarters.fill(0, @quarters.size, 4 - @quarters.size)
        end
      end

      # Sum the score of each quarter
      def score
        @quarters.inject(:+)
      end
    end
  end
end