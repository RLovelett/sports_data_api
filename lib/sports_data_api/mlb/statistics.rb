module SportsDataApi
  module Mlb
    class Statistics < JsonData
      def pitching
        @pitching ||= orphan_stat :pitching
      end

      def fielding
        @fielding ||= orphan_stat :fielding
      end

      def hitting
        @hitting ||= orphan_stat :hitting
      end

      private

      def orphan_stat(key)
        return unless statistics.has_key? key
        MergedStats.new(statistics[key]['overall'], key.to_s)
      end
    end
  end
end
