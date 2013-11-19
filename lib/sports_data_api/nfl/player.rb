module SportsDataApi
  module Nfl
    class Player
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          player_ivar = self.instance_variable_set("@#{xml.name}", {})
          self.class.class_eval { attr_reader :"#{xml.name}" }
          xml.attributes.each do | attr_name, attr_value|
            player_ivar[attr_name.to_sym] = attr_value.value
          end
        end
      end
    end
  end
end
