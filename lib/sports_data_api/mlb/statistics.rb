module SportsDataApi
  module Mlb
    class Statistics < JsonData
      def pitching
        @pitching ||= orphan_stat(:pitching, MergedStats)
      end

      def fielding
        @fielding ||= orphan_stat(:fielding, MergedStats)
      end

      def hitting
        @hitting ||= orphan_stat(:hitting, MergedStats)
      end

      private

      def orphan_stat(key, klass)
        return unless statistics.has_key? key
        klass.new(statistics[key]['overall'], key.to_s)
      end
    end
  end
end
