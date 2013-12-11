module SportsDataApi
  module Nba
    class Team
      attr_reader :id, :name, :market, :alias, :conference, :division,
                  :stats, :players

      def initialize(xml, conference = nil, division = nil)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @name = xml['name']
          @market = xml['market']
          @alias = xml['alias']
          @conference = conference
          @division = division
          @players = xml.xpath("players/player").map do |player_xml|
            Player.new(player_xml)
          end
        end
      end

      ##
      # Compare the Team with another team
      def ==(other)
        # Must have an id to compare
        return false if self.id.nil?

        if other.is_a? SportsDataApi::Nba::Team
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
