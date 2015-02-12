module SportsDataApi
  module Ncaamb
    class TournamentGame < SimpleDelegator
      attr_reader :id, :round_number, :round_name, :bracket

      def initialize(args={})
        xml = args.fetch(:xml)
        @bracket = args[:bracket]
        round = args[:round] || {}
        @round_name = round[:name]
        @round_number = round[:number] ? round[:number].to_i : nil

        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
        end

        super(Game.new(year: args[:year], season: args[:season], xml: xml))
      end

    end
  end
end