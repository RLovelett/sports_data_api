module SportsDataApi
  module Nba
    class Team
      attr_reader :id, :name, :market, :alias, :conference, :division, :stats

      def initialize(json, conference = nil, division = nil)
        @conference = conference
        @division = division
        @id = json['id']
        @name = json['name']
        @market = json['market']
        @alias = json['alias']
        @points = json['points']
        @alias = json['alias']
        @json = json
      end

      def points
        @points ||= json['points'] ? json['points'].to_i : nil
      end

      def players
        return [] if json['players'].nil? || json['players'].empty?
        @players ||= json['players'].map { |x| Player.new(x) }
      end

      def venue
        @venue ||= Venue.new(json['venue']) if json['venue']
      end

      ##
      # Compare the Team with another team
      def ==(other)
        # Must have an id to compare
        return false if id.nil?

        if other.is_a? SportsDataApi::Nba::Team
          other.id && id === other.id
        elsif other.is_a? Symbol
          id.to_sym === other
        else
          super(other)
        end
      end

      private

      attr_reader :json
    end
  end
end
