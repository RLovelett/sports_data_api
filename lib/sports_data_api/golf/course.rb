module SportsDataApi
  module Golf
    class Course
      attr_reader :name, :yardage, :par, :id

      def initialize(data)
        @data = data
        @name = data['name']
        @id = data['id']
        @yardage = data['yardage']
        @par = data['par']
      end

      def pairings
        @pairings ||= data['pairings'].map do |json|
          Pairing.new(json)
        end
      end

      private

      attr_reader :data
    end
  end
end
