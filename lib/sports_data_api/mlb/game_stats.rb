module SportsDataApi
  module Mlb
    class GameStats
      include Enumerable

      def initialize(xml)
        @stats = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        xml.children.each do |child|
          next unless child.is_a? Nokogiri::XML::Element
          child.children.each do |grandchild|
            next unless grandchild.is_a? Nokogiri::XML::Element
            grandchild.xpath('players').xpath('player').each do |player|
              @stats << GameStat.new(player)
            end
          end
        end

        @stats
      end

      def [](search_index)
        found_index = @stats.index(search_index)
        unless found_index.nil?
          @stats[found_index]
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
