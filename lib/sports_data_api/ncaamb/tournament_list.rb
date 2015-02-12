module SportsDataApi
  module Ncaamb
    class TournamentList
      attr_reader :id, :year, :season, :tournaments

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::NodeSet
          @id = xml.first["id"]
          @year = xml.first["year"].to_i
          @season = xml.first["type"].to_sym

          @tournaments = xml.first.xpath("tournament").map do |tournament_xml|
            Tournament.new(year: @year, season: @season, xml: tournament_xml)
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
