module SportsDataApi
  module Nhl
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :venue, :broadcast, :year, :season,
        :date, :period, :clock

      def initialize(args={})
        xml = args.fetch(:xml)
        @year = args[:year] ? args[:year].to_i : nil
        @season = args[:season] ? args[:season].to_sym : nil
        @date = args[:date]

        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @scheduled = Time.parse xml['scheduled']
          @home = xml['home_team']
          @away = xml['away_team']
          @status = xml['status']
          @clock = xml['clock']
          @period = xml['period'] ? xml['period'].to_i : nil

          team_xml = xml.xpath('team')
          @home_team = Team.new(team_xml.first)
          @away_team = Team.new(team_xml.last)
          @venue = Venue.new(xml.xpath('venue'))
          @broadcast = Broadcast.new(xml.xpath('broadcast'))
        end
      end

      ##
      # Wrapper for Nhl.game_summary
      # TODO
      def summary
        Nhl.game_summary(@id)
      end

      ##
      # Wrapper for Nhl.pbp (Nhl.play_by_play)
      # TODO
      def pbp
        raise NotImplementedError
      end

      ##
      # Wrapper for Nhl.boxscore
      # TODO
      def boxscore
        raise NotImplementedError
      end
    end
  end
end
