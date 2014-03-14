module SportsDataApi
  module Mlb
    class Boxscore
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml['status'] == 'closed'
          inning = xml.xpath('final').first
          boxscore_ivar = self.instance_variable_set("@game_state", {})
          self.class.class_eval { attr_reader :"game_state" }
          inning.attributes.each do | attr_name, attr_value|
            boxscore_ivar[attr_name.to_sym] = attr_value.value
          end
        elsif xml['status'] == 'inprogress'
          inning = xml.xpath('outcome').first
          boxscore_ivar = self.instance_variable_set("@game_state", {})
          self.class.class_eval { attr_reader :"game_state" }
          boxscore_ivar[:inning] = inning.attributes['current_inning'].value
          boxscore_ivar[:inning_half] = inning.attributes['current_inning_half'].value
        end
      end
    end
  end
end
