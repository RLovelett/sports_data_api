module SportsDataApi
  module Nfl
    class Quarters
      include Enumerable
      attr_reader :quarters

      def initialize(quarters_hash)
        @quarters = quarters_hash.map do |quarter|
          Quarter.new(quarter)
        end
      end

      def each &block
        quarters.each do |quarter|
          if block_given?
            block.call quarter
          else
            yield quarter
          end
        end
      end
    end
  end
end
