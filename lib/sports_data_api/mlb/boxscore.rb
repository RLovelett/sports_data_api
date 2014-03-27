module SportsDataApi
  module Mlb
    class Boxscore
      VALID_GAME_STATUSES = ['closed', 'inprogress']
        
      def initialize(xml)
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        return unless VALID_GAME_STATUSES.include? xml['status'].to_s.downcase

        boxscore_ivar = self.instance_variable_set("@game_state", {})
        self.class.class_eval { attr_reader :"game_state" }

        visitor = xml.xpath("visitor").first
        boxscore_ivar[:visitor_score] = visitor.attributes["runs"].value

        home = xml.xpath("home").first
        boxscore_ivar[:home_score] = home.attributes["runs"].value

        if xml['status'] == 'closed'
          inning = xml.xpath('final').first
          inning.attributes.each do | attr_name, attr_value|
            boxscore_ivar[attr_name.to_sym] = attr_value.value
          end
        elsif xml['status'] == 'inprogress'
          inning = xml.xpath('outcome').first
          boxscore_ivar[:inning] = inning.attributes['current_inning'].value
          boxscore_ivar[:inning_half] = inning.attributes['current_inning_half'].value
        end
      end
    end
  end
end
