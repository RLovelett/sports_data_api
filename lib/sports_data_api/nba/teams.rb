module SportsDataApi
  module Nba
    class Teams
      include Enumerable

      def initialize(json)
        @json = json
      end

      def teams
        @teams ||= json.fetch('conferences', []).flat_map do |conference|
          conference['divisions'].flat_map do |division|
            division['teams'].map do |json|
              Team.new(json, conference['alias'], division['alias'])
            end
          end
        end
      end

      ##
      # Make the class Enumerable
      def each
        return teams.each unless block_given?
        teams.each { |team| yield team }
      end

      private

      attr_reader :json
    end
  end
end
