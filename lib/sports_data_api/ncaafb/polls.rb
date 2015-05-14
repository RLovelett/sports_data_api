module SportsDataApi
  module Ncaafb
    class Polls
      include Enumerable

      attr_reader :id, :name, :season, :season_type, :week, :rankings, :candidates
      def initialize(polls_hash)
        @id = polls_hash['id']
        @name = polls_hash['name']
        @season = polls_hash['season']
        @season_type = polls_hash['season_type']
        @week = polls_hash['week']
        @rankings = []
        @candidates = []
        add_poll_teams_to(@rankings, polls_hash['rankings'])
        add_poll_teams_to(@candidates, polls_hash['candidates'])
      end

      ##
      # Make the class Enumerable
      def each(&block)
        @rankings.each do |team|
          if block_given?
            block.call team
          else
            yield team
          end
        end
      end

      class << self
        ##
        # Check if the requested poll is a valid
        # Ncaafb poll type.
        #
        # The only valid polls are: :AP25, :EU25, :CFP25, :FCSC25, :H25, :FCS25
        def valid_name?(poll)
          [:AP25, :EU25, :CFP25, :FCSC25, :H25, :FCS25].include?(poll.upcase.to_sym)
        end

        # The only valid week nr is 1..21
        def valid_week?(week)
          (1..21).include?(week.to_i)
        end
      end

      private
      def add_poll_teams_to(collection, hash_colection)
        Array(hash_colection).each do |poll_team|
          collection << PollTeam.new(poll_team)
        end
      end
    end
  end
end
