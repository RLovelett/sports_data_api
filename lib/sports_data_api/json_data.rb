module SportsDataApi
  class JsonData
    def initialize(json)
      attr_name = class_name
      ivar = self.instance_variable_set("@#{attr_name}", {})
      self.class.class_eval { attr_reader :"#{attr_name}" }
      json.each_pair do |attr_name, attr_value|
        ivar[attr_name.to_sym] = attr_value
      end
    end

    def [](key)
      self.instance_variable_get("@#{class_name}")[key]
    end

    private

    def class_name
      @class_name ||= self.class.name.downcase.split('::').last
    end
  end
end
