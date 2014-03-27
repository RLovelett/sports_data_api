module SportsDataApi
  module Mlb
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :venue, :broadcast, :year, :season,
        :date, :quarter, :clock

      def initialize(args={})
        xml = args.fetch(:xml)
        @year = args[:year] ? args[:year].to_i : nil

        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @scheduled = Time.parse(xml.xpath('scheduled_start').children.first.to_s)
          @home = xml['home']
          @away = xml['visitor']
          @status = xml['status']
          @venue = xml['venue']
          @broadcast = Broadcast.new(xml.xpath('broadcast'))
        end
      end
    end
  end
end
