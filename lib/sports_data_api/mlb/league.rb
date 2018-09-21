module SportsDataApi
  module Mlb
    class League < JsonData
      def divisions
        @divisions ||= league.fetch(:divisions, []).map do |data|
          Division.new(data)
        end
      end

      def teams
        @teams ||= divisions.flat_map do |division|
          division.teams.flat_map do |team|
            team.tap do |t|
              t.team[:conference] = league[:alias]
              t.team[:conference_name] = league[:name]
            end
          end
        end
      end
    end
  end
end
