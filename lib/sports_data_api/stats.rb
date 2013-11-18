module SportsDataApi
  class Stats
    def initialize(xml)
      if xml.is_a? Nokogiri::XML::Element
        stat_ivar = self.instance_variable_set("@#{xml.name}", {})
        self.class.class_eval { attr_reader :"#{xml.name}" }
        xml.attributes.each do | attr_name, attr_value|
          stat_ivar[attr_name.to_sym] = attr_value.value
        end
      end
    end
  end
end
