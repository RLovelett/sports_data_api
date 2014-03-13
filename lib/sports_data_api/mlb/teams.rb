module SportsDataApi
  module Mlb
    class Teams
      include Enumerable

      attr_reader :leagues, :divisions

      ##
      # Initialize by passing the raw XML returned from the API
      def initialize(xml)
        @teams = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          xml.xpath('//team').each do |team|
            @teams << Team.new(team) if !team['league'].empty?
          end
        end

        @teams
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
        @teams.each do |team|
          if block_given?
            block.call team
          else
            yield team
          end
        end
      end
    end
  end
end
