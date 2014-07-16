module SportsDataApi
  module Mlb
    class GameStats
      include Enumerable

      def initialize(xml)
        @stats = {}
        @stats[:hitting] = []
        @stats[:pitching] = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        @stats[:status] = xml['status']
        xml.children.each do |child|
          next unless child.is_a? Nokogiri::XML::Element
          child.xpath("hitting").xpath("players").xpath("player").each do |player|
            @stats[:hitting] << GameStat.new(player)
          end

          child.xpath("pitching").xpath("players").xpath("player").each do |player|
            @stats[:pitching] << GameStat.new(player)
          end
        end
        @stats
      end

      def [](search_index)
        if @stats.has_key?(search_index)
          @stats[search_index]
        end
      end

      ##
      # Make the class Enumerable
      def each(&block)
        @stats.each do |stat|
          if block_given?
            block.call stat
          else
            yield stat
          end
        end
      end
    end
  end
end
