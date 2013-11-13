module SportsDataApi
  module Nfl
    class TeamRoster
      attr_reader :id, :first_name, :last_name, :full_name, :abrv_name, :birthdate,
      :height, :weight, :position, :jersey_number, :status, :college

      def initialize(xml)
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @first_name = xml['name_first']
          @last_name = xml['name_last']
          @full_name = xml['name_full']
          @abrv_name = xml['name_abbr']
          @birthdate = xml['birthdate']
          @height = xml['height']
          @weight = xml['weight']
          @position = xml['position']
          @jersey_number = xml['jersey_number']
          @status = xml['status']
          @college = xml['college']
        end
      end
    end
  end
end
