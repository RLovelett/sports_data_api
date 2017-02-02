module SportsDataApi
  class Stats
    def initialize(xml)
      if xml.is_a? Nokogiri::XML::Element
        stat_ivar = self.instance_variable_set("@#{xml.name}", {})
        self.class.class_eval { attr_reader :"#{xml.name}" }

        xml.attributes.each { |attr_name, attr_value| stat_ivar[attr_name.to_sym] = attr_value.value }
        xml.children.each do |child_stat|
          if child_stat.is_a? Nokogiri::XML::Element
            child_stat.attributes.each { |attr_name, attr_value| stat_ivar["#{child_stat.name}_#{attr_name}".to_sym] = attr_value.value }
          end
        end
      end
    end
  end
end
