module SportsDataApi
  class JsonData
    def initialize(json)
      instance_var_name = class_name
      ivar = self.instance_variable_set("@#{instance_var_name}", {})
      self.class.class_eval { attr_reader :"#{instance_var_name}" }
      json.each_pair do |attr_name, attr_value|
        ivar[attr_name.to_sym] = attr_value
      end
    end

    def [](key)
      return send(key) if respond_to?(key)
      self.instance_variable_get("@#{class_name}")[key]
    end

    private

    def class_name
      @class_name ||= self
        .class
        .name
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .split('::')
        .last
        .downcase
    end
  end
end
