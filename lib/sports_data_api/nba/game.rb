module SportsDataApi
  module Nba
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :venue, :broadcast, :year, :season,
        :date, :quarter, :clock, :home_team_id, :away_team_id

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
          @quarter = xml['quarter'] ? xml['quarter'].to_i : nil

          team_xml = xml.xpath('team')
          if team_xml.empty?
            # we are coming from the schedule API
            @home_team = Team.new(xml.xpath('home'))
            @away_team = Team.new(xml.xpath('away'))
          else
            # we are coming from the Game Summary API
            @home_team = Team.new(team_xml.first)
            @away_team = Team.new(team_xml.last)
          end

          @venue = Venue.new(xml.xpath('venue'))
          @broadcast = Broadcast.new(xml.xpath('broadcast'))
        end
      end

      ##
      # Wrapper for Nba.game_summary
      # TODO
      def summary
        Nba.game_summary(@id)
      end

      ##
      # Wrapper for Nba.pbp (Nba.play_by_play)
      # TODO
      def pbp
        raise NotImplementedError
      end

      ##
      # Wrapper for Nba.boxscore
      # TODO
      def boxscore
        raise NotImplementedError
      end
    end
  end
end
