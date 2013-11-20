module SportsDataApi
  module Nfl
    class Season
      attr_reader :year, :type, :weeks

      def initialize(xml)
        @weeks = []
        if xml.is_a? Nokogiri::XML::NodeSet
          @year = xml.first["season"].to_i
          @type = xml.first["type"].to_sym
          @weeks = xml.first.xpath("week").map do |week_xml|
            Week.new(@year, @type, week_xml)
          end
        end
      end

      ##
      # Check if the requested season is a valid
      # NFL season type.
      #
      # The only valid types are: :PRE, :REG, :PST
      def self.valid?(season)
        [:PRE, :REG, :PST].include?(season)
      end
    end
  end
end
