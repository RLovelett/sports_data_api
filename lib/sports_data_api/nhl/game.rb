module SportsDataApi
  module Nhl
    class Game
      attr_reader :id, :status, :year, :season, :clock,
        :home_team_id, :away_team_id

      def initialize(json:, year: nil, season: nil)
        @json = json
        @year = year
        @season = season
        @id = json['id']
        @home_team_id = json['home']['id']
        @away_team_id = json['away']['id']
        @status = json['status']
        @clock = json['clock']
      end

      def period
        return unless json['period']
        json['period'].to_i
      end

      def scheduled
        @scheduled = Time.parse(json['scheduled'])
      end

      def home_team
        @home_team ||= Team.new(json['home'])
      end

      def away_team
        @away_team ||= Team.new(json['away'])
      end

      def broadcast
        return if json['broadcast'].nil? || json['broadcast'].empty?
        @broadcast ||= Broadcast.new(json['broadcast'])
      end

      def venue
        return if json['venue'].nil? || json['venue'].empty?
        @venue ||= Venue.new(json['venue'])
      end

      ##
      # Wrapper for Nhl.game_summary
      def summary
        Nhl.game_summary(id)
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

      private

      attr_reader :json
    end
  end
end
