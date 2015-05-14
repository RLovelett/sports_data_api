module SportsDataApi
  module Ncaafb
    class PollTeam
      attr_reader :id, :name, :market, :points, :fp_votes, :wins, :losses, :ties, :rank
      def initialize(poll_team_hash)
        @id = poll_team_hash['id']
        @name = poll_team_hash['name']
        @rank = poll_team_hash['rank']
        @market = poll_team_hash['market']
        @points = poll_team_hash['points']
        @fp_votes = poll_team_hash['fp_votes']
        @wins = poll_team_hash['wins']
        @losses = poll_team_hash['losses']
        @ties = poll_team_hash['ties']
      end
    end
  end
end
