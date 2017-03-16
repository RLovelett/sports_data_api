module SportsDataApi
  module Nfl
    class Game
      attr_reader :id, :scheduled, :home, :home_team, :away,
        :away_team, :status, :quarter, :clock, :venue, :broadcast, :weather,
        :year, :season, :week, :home_team_id, :away_team_id

      def initialize(year, season, week, game_hash)
        @year = year
        @season = season
        @week = week

        @id = game_hash['id']
        @scheduled = Time.parse game_hash['scheduled']
        @home = game_hash['home'] || game_hash['home_team']['id']
        @away = game_hash['away'] || game_hash['away_team']['id']
        @home_team_id = @home
        @away_team_id = @away
        @status = game_hash['status']
        @quarter = game_hash['quarter'].to_i
        @clock = game_hash['clock']

        @home_team = Team.new(game_hash['home_team'])
        @away_team = Team.new(game_hash['away_team'])
        @venue = Venue.new(game_hash['venue'])
        @broadcast = Broadcast.new(game_hash['broadcast'])
        @weather = Weather.new(game_hash['weather'])
      end

      ##
      # Wrapper for Nfl.statistics
      def statistics
        Nfl.game_statistics(year, season, week, home, away)
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
        Nfl.boxscore(year, season, week, home, away)
      end

      ##
      # Wrapper for Nfl.game_roster
      def roster
        Nfl.game_roster(year, season, week, home, away)
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
