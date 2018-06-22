require 'forwardable'

module SportsDataApi
  module Nfl
    class Teams
      extend Forwardable
      include Enumerable

      def_delegators :teams, :each

      def initialize(json)
        @json = json
      end

      def teams
        @teams ||= json['conferences'].flat_map do |conference_json|
          conference = conference_json['name']
          conference_json['divisions'].flat_map do |division_json|
            division = division_json['name']
            division_json['teams'].flat_map do |team_json|
              Team.new(team_json, conference: conference, division: division)
            end
          end
        end
      end

      private

      attr_reader :json
    end
  end
end
