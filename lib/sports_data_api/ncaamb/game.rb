module SportsDataApi
  module Ncaamb
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :venue, :broadcast, :year, :season,
        :date, :half, :clock, :home_team_id, :away_team_id

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
          @home_team_id = xml['home_team']
          @away_team_id = xml['away_team']
          @status = xml['status']
          @clock = xml['clock']
          @half = xml['half'] ? xml['half'].to_i : nil

          team_xml = xml.xpath('team')
          @home_team = Team.new(team_xml.first)
          @away_team = Team.new(team_xml.last)
          @venue = Venue.new(xml.xpath('venue'))
          @broadcast = Broadcast.new(xml.xpath('broadcast'))
        end
      end

      def summary
        Ncaamb.game_summary(@id)
      end

      ##
      # Wrapper for NCAAMB.pbp (NCAAMB.play_by_play)
      # TODO
      def pbp
        raise NotImplementedError
      end

      ##
      # Wrapper for NCAAMB.boxscore
      # TODO
      def boxscore
        raise NotImplementedError
      end
    end
  end
end
