module SportsDataApi
  module Mlb
    class Team
      attr_reader :id, :name, :market, :alias, :league, :division

      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @market = xml['market']
          @alias = xml['abbr']
          @league = xml['league']
          @division = xml['division']
        end
      end

      ##
      # Compare the Team with another team
      def ==(other)
        # Must have an id to compare
        return false if id.nil?

        if other.is_a? SportsDataApi::Mlb::Team
          other.id && id === other.id
        elsif other.is_a? Symbol
          id.to_sym === other
        else
          super(other)
        end
      end
    end
  end
end
