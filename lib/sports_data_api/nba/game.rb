module SportsDataApi
  module Nba
    class Game
      attr_reader :id, :status, :year, :season, :clock

      def initialize(json:, year: nil, season: nil)
        @json = json
        @year = year
        @season = season
        @id = json['id']
        @status = json['status']
        @clock = json['clock']
      end

      def scheduled
        @scheduled ||= Time.iso8601 json['scheduled']
      end

      def home_team_id
        json['home']['id']
      end

      def away_team_id
        json['away']['id']
      end

      def home_team
        @home_team ||= Team.new(json['home'])
      end

      def away_team
        @away_team ||= Team.new(json['away'])
      end

      def quarter
        return unless json['quarter']
        json['quarter'].to_i
      end

      def venue
        @venue ||= Venue.new(json['venue'])
      end

      def broadcast
        return nil if json['broadcast'].nil? || json['broadcast'].empty?
        @broadcast ||= Broadcast.new(json['broadcast'])
      end

      ##
      # Wrapper for Nba.game_summary
      # TODO
      def summary
        Nba.game_summary(id)
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

      private

      attr_reader :json

      def game_summary?
        !team_json.nil?
      end

      def team_json
        @team_json ||= json['team']
      end
    end
  end
end
