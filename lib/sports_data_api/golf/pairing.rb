module SportsDataApi
  module Golf
    class Pairing
      attr_reader :tee_time, :back_nine

      def initialize(data)
        @data = data
        @tee_time = DateTime.parse(data['tee_time']) if data['tee_time']
        @back_nine = data['back_nine']
      end

      def players
        @players ||= data.fetch('players', []).map do |json|
          Player.new(json)
        end
      end

      private

      attr_reader :data
    end
  end
end
