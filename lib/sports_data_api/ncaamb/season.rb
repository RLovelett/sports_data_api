module SportsDataApi
  module Ncaamb
    class Season
      attr_reader :id, :year, :type, :games

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::NodeSet
          @id = xml.first["id"]
          @year = xml.first["year"].to_i
          @type = xml.first["type"].to_sym

          @games = xml.first.xpath("games/game").map do |game_xml|
            Game.new(year: @year, season: @type, xml: game_xml)
          end
        end
      end

      ##
      # Check if the requested season is a valid
      # NCAAMB season type.
      #
      # The only valid types are: :reg, :pst, :ct
      def self.valid?(season)
        [:REG, :PST, :CT].include?(season)
      end
    end
  end
end
