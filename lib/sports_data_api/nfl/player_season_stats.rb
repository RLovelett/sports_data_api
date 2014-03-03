module SportsDataApi
  module Nfl
    class PlayerSeasonStats
      attr_reader :stats, :id, :players
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        @players = []
        xml.xpath("player").each do | p |
          player = {}
          stats = []

          p.children.each do | stat |
            if stat.name == "text"
              next
            end
            stats << SportsDataApi::Stats.new(stat)
          end

          player[:id] = p['id']
          player[:stats] = stats
          @players << player
        end
      end
    end
  end
end
