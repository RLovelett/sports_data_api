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

      ##
      # Wrapper for Nfl.statistics
      # TODO
      def statistics
        raise NotImplementedError
      end

      ##
      # Wrapper for Nfl.summary
      # TODO
      def summary
        raise NotImplementedError
      end

      ##
      # Wrapper for Nfl.pbp (Nfl.play_by_play)
      # TODO
      def pbp
        raise NotImplementedError
      end

      ##
      # Wrapper for Nfl.boxscore these helper methods are used
      # to provide similar functionality as the links attribute
      # found in the weekly schedule example.
      def boxscore
        Nfl.boxscore(year, season, week, home, away, 1)
      end

      ##
      # Wrapper for Nfl.roster
      # TODO
      def roster
        raise NotImplementedError
      end

      ##
      # Wrapper for Nfl.injuries
      # TODO
      def injuries
        raise NotImplementedError
      end

      ##
      # Wrapper for Nfl.depthchart
      # TODO
      def depthchart
        raise NotImplementedError
      end
    end
  end
end