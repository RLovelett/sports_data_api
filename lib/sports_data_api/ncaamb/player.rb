module SportsDataApi
  module Ncaamb
    class Player
      attr_reader :stats

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          player_ivar = self.instance_variable_set("@#{xml.name}", {})
          self.class.class_eval { attr_reader :"#{xml.name}" }
          xml.attributes.each do | attr_name, attr_value|
            player_ivar[attr_name.to_sym] = attr_value.value
          end

          stats_xml = xml.xpath('statistics')
          if stats_xml.is_a? Nokogiri::XML::NodeSet and stats_xml.count > 0
            @stats = SportsDataApi::Stats.new(stats_xml.first)
          end
        end
      end
    end
  end
end
