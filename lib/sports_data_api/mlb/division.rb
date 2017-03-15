module SportsDataApi
  module Mlb
    class Division < JsonData
      def teams
        @teams ||= division[:teams].map do |data|
          Team.new(data).tap do |t|
            t.team[:division] = division[:name]
            t.team[:division_alias] = division[:alias]
          end
        end
      end
    end
  end
end
