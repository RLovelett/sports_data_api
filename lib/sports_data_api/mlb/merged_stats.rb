module SportsDataApi
  module Mlb
    class MergedStats < JsonData
      def initialize(json, override_var_name = nil)
        super(json, override_var_name)
        ivar = instance_variable_get("@#{instance_var_name}")
        json.each do |key, val|
          next unless val.is_a? Hash
          json[key].each do |sub_key, data|
            ivar["#{key}_#{sub_key}".to_sym] = data
          end
          ivar.delete key.to_sym
        end
      end
    end
  end
end
