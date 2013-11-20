module SportsDataApi
  module Nfl
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :quarter, :clock, :venue, :broadcast, :weather,
        :year, :season, :week

      def initialize(year, season, week, xml)
        @year = year.to_i
        @season = season.to_sym
        @week = week.to_i

        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @scheduled = Time.parse xml['scheduled']
          @home = xml['home']
          @away = xml['away']
          @status = xml['status']
          @quarter = xml['quarter'].to_i
          @clock = xml['clock']

          team_xml = xml.xpath('team')
          @home_team = Team.new(team_xml.first)
          @away_team = Team.new(team_xml.last)
          @venue = Venue.new(xml.xpath('venue'))
          @broadcast = Broadcast.new(xml.xpath('broadcast'))
          @weather = Weather.new(xml.xpath('weather'))
        end
      end
    end
  end
end