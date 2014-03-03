module SportsDataApi
  module Nba
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
      # NBA season type.
      #
      # The only valid types are: :pre, :reg, :pst
      def self.valid?(season)
        [:PRE, :REG, :PST].include?(season)
      end
    end
  end
end
