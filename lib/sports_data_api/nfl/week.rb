module SportsDataApi
  module Nfl
    class Week
      attr_reader :number, :games, :year, :season

      def initialize(year, season, xml)
        @games = []
        @year = year
        @season = season

        if xml.is_a? Nokogiri::XML::Element
          @number = xml["week"].to_i
          @games = xml.xpath("game").map do |game_xml|
            Game.new(@year, @season, @number, game_xml)
          end
        end
      end
    end
  end
end
