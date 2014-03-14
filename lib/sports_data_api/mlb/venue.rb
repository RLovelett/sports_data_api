module SportsDataApi
  module Mlb
    class Venue
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          venue_ivar = self.instance_variable_set("@#{xml.name}", {})
          self.class.class_eval { attr_reader :"#{xml.name}" }
          xml.attributes.each do | attr_name, attr_value|
            venue_ivar[attr_name.to_sym] = attr_value.value
          end
        end
      end
    end
  end
end
