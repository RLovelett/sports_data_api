module SportsDataApi
  class Data
    def initialize(json)
      player_ivar = self.instance_variable_set("@player", {})
      self.class.class_eval { attr_reader :"player" }
      json.each_pair do |attr_name, attr_value|
        player_ivar[attr_name.to_sym] = attr_value
      end
    end

    def [](key)
      @player[key]
    end
  end
end
