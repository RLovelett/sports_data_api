module SportsDataApi
  module Nfl
    class TeamSeasonStats
      attr_reader :id, :stats
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        @id = xml['id']
        @stats = []
        xml.xpath("players").remove
        xml.children.each do | stat |
          if stat.name == "text"
            next
          end
          @stats << SportsDataApi::Stats.new(stat)
        end
      end
    end
  end
end
