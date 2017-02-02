module SportsDataApi
  module Ncaafb
    class Team
      attr_reader :id, :name, :conference, :division, :market, :remaining_challenges,
                  :remaining_timeouts, :score, :quarters, :venue, :points, :statistics, :players, :subdivision

      def initialize(team_hash, conference = nil, division = nil, subdivision = nil)
        if team_hash
          @id = team_hash['id']
          @name = team_hash['name']
          @conference = conference
          @division = division
          @subdivision = subdivision
          @market = team_hash['market']
          @remaining_challenges = team_hash['remaining_challenges']
          @remaining_timeouts = team_hash['remaining_timeouts']
          @quarters = []
          if team_hash['scoring']
            team_hash['scoring'].each do |scoring_hash|
              @quarters[scoring_hash['quarter']-1] = scoring_hash['points']
            end
          end
          @quarters = @quarters.fill(0, @quarters.size, 4 - @quarters.size)

          # Parse the Venue data if it exists
          if team_hash.key?('venue')
            @venue = Venue.new(team_hash['venue'])
          end

          if team_hash['statistics']
            @statistics = parse_team_statistics(team_hash['statistics'])
            @players = parse_player_statistics(team_hash['statistics'])
          end

          if team_hash['players']
            @players = TeamRoster.new(team_hash).players
          end
          @points = team_hash['points'] || score
        end
      end

      # Sum the score of each quarter
      def score
        @quarters.inject(:+)
      end

      ##
      # Compare the Team with another team
      def ==(other)
        # Must have an id to compare
        return false if id.nil?

        if other.is_a? SportsDataApi::Ncaafb::Team
          other.id && id === other.id
        elsif other.is_a? Symbol
          id.to_sym === other
        else
          super(other)
        end
      end

      private

      def parse_team_statistics(stats_hash)
        stats = {}
        stats_hash.keys.each do |key|
          stats[key] = stats_hash[key]['team']
        end
        stats
      end

      def parse_player_statistics(stats_hash)
        players = []
        stats_hash.keys.each do |key|
          next if !stats_hash[key]['players']
          stats_hash[key]['players'].each do |p|
            player = players.select{|a| a['id'] == p['id']}.first || {}
            players << player if !players.select{|a| a['id'] == p['id']}.first
            ['id', 'name', 'jersey', 'position'].each do |k|
              player[k] = p.delete(k)
            end
            player[key] = p
          end
        end
        players
      end
    end
  end
end
