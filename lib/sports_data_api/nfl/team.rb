module SportsDataApi
  module Nfl
    class Team
      attr_reader :id, :name, :conference, :division, :market, :remaining_challenges, :remaining_timeouts, :score, :quarters, :venue

      def initialize(xml, conference = nil, division = nil)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @conference = conference
          @division = division
          @market = xml['market']
          @remaining_challenges = xml['remaining_challenges'].to_i
          @remaining_timeouts = xml['remaining_timeouts'].to_i
          @quarters = xml.xpath('scoring/quarter').map do |quarter|
            quarter['points'].to_i
          end
          @quarters = @quarters.fill(0, @quarters.size, 4 - @quarters.size)

          # Parse the Venue data if it exists
          venue_xml = xml.xpath('venue')
          @venue = Venue.new(venue_xml) if venue_xml
        end
      end

      # Sum the score of each quarter
      def score
        @quarters.inject(:+)
      end

      ##
      # Compare the Team with another team
      def ==(other)
        # Must have an id to compare
        return false if self.id.nil?

        if other.is_a? SportsDataApi::Nfl::Team
          return false if other.id.nil?
          self.id === other.id
        elsif other.is_a? Symbol
          self.id.to_sym === other
        else
          super(other)
        end
      end

    end
  end
end
