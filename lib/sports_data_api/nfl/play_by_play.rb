module SportsDataApi
  module Nfl
    class PlayByPlay
      attr_reader :id, :scheduled, :completed, :home, :home_team, :away,
        :away_team, :status, :year, :season, :week, :quarters

      def initialize(year, season, week, play_by_play_hash)
        @year = year
        @season = season
        @week = week

        @id = play_by_play_hash['id']
        @scheduled = Time.parse play_by_play_hash['scheduled']
        @completed = Time.parse play_by_play_hash['completed']
        @home = play_by_play_hash['home'] || play_by_play_hash['home_team']['id']
        @away = play_by_play_hash['away'] || play_by_play_hash['away_team']['id']
        @status = play_by_play_hash['status']

        @home_team = Team.new(play_by_play_hash['home_team'])
        @away_team = Team.new(play_by_play_hash['away_team'])

        @away_team = Team.new(play_by_play_hash['away_team'])

        @quarters = Quarters.new(play_by_play_hash["quarters"])
      end

      ##
      # Wrapper for Nfl.statistics
      def statistics
        Nfl.game_statistics(year, season, week, home, away, 1)
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
