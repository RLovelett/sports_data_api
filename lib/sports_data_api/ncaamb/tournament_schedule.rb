module SportsDataApi
  module Ncaamb
    class TournamentSchedule
      attr_reader :id, :name, :games, :season, :year

      def initialize(year, season, xml)
        if xml.is_a? Nokogiri::XML::NodeSet
          @id = xml.first["id"]
          @name = xml.first["name"]
          @year = year.to_i
          @season = season

          @games = xml.first.xpath("round").map { |round_xml|
            games_from_round(round_xml)
          }.flatten
        end
      end

      # Check if the requested tournament is a valid
      # NCAAMB tournament type.
      #
      # The only valid types are: :reg, :pst, :ct
      def self.valid?(season)
        [:REG, :PST, :CT].include?(season)
      end

      private

      def games_from_round(round_xml)
        round = {
          number: round_xml['sequence'],
          name: round_xml['name'] 
        }
        if round_xml.xpath('bracket').first
          round_xml.xpath('bracket').map do |bracket_xml|
            traverse_games(bracket_xml, round, bracket_xml['name'])
          end
        else
          traverse_games(round_xml, round, nil)
        end
      end

      def traverse_games(xml, round, bracket_name)
        xml.xpath('game').map do |game_xml|
          TournamentGame.new(round: round, bracket: bracket_name, year: year, season: season, xml: game_xml)
        end
      end

    end
  end
end