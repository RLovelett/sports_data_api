module SportsDataApi
  module Nfl
    class Week
      attr_reader :number, :games

      def initialize(xml)
        @games = []
        if xml.is_a? Nokogiri::XML::Element
          @number = xml["week"].to_i
          @games = xml.xpath("game").map do |game_xml|
            Game.new(game_xml)
          end
        end
      end
    end
  end
end
