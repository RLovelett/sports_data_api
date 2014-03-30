module SportsDataApi
  module Mlb
    class Players
      include Enumerable

      ##
      # Initialize by passing the raw XML returned from the API
      def initialize(xml)
        @players = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          xml.xpath('team').each do |team|
            team.xpath('players').xpath('player').each do |player|
              p = Player.new(player, team['id'])
              @players << p
            end
          end
        end
        @players
      end

      def [](search_index)
        found_index = @teams.index(search_index)
        unless found_index.nil?
          @teams[found_index]
        end
      end

      ##
      # Make the class Enumerable
      def each(&block)
        @players.each do |player|
          if block_given?
            block.call player
          else
            yield player
          end
        end
      end
    end
  end
end
