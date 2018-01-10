module SportsDataApi
  module Nhl
    class Team
      attr_reader :id, :name, :market, :alias

      def initialize(json, conference = nil, division = nil)
        @json = json
        @id = json['id']
        @name = json['name']
        @market = json['market']
        @alias = json['alias']
        @conference = conference
        @division = division
      end

      def conference
        @conference ||= json.fetch('conference', {})['alias']
      end

      def division
        @division ||= json.fetch('division', {})['alias']
      end

      def points
        return unless json['points']
        json['points'].to_i
      end

      def players
        return [] if json['players'].nil?
        @players ||= json['players'].map do |player_json|
          Player.new(player_json)
        end
      end

      def venue
        return if json['venue'].nil?
        @venue ||= Venue.new(json['venue'])
      end

      ##
      # Compare the Team with another team
      def ==(other)
        return false if id.nil?

        if other.is_a? SportsDataApi::Nhl::Team
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
