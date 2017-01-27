module SportsDataApi
  module Golf
    class Player
      attr_reader :id, :first_name, :last_name, :height, :weight, :birthday,
        :country, :residence, :college, :turned_pro, :member, :updated

      def initialize(data)
        @id = data['id']
        @first_name = data['first_name']
        @last_name = data['last_name']
        @height = data['height']
        @weight = data['weight']
        @birthday = Date.parse(data['birthday']) if data['birthday']
        @country = data['country']
        @residence = data['residence']
        @college = data['college']
        @turned_pro = data['turned_pro']
        @member = data['member']
        @updated = DateTime.parse(data['updated'])
      end
    end
  end
end
