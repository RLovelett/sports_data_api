module SportsDataApi
  module Odds
    class Game
      include Virtus.model

      attribute :id
      attribute :scheduled
      attribute :home_team_id
      attribute :home_team
      attribute :away_team_id
      attribute :away_team
      attribute :spread, Float

      def self.load_from_xml(xml, date)
        new({
          id: xml.css('GameID').text,
          scheduled: "#{date} #{xml.css('Time').text}",
          home_team_id: xml.css('HomeID').text,
          home_team: xml.css('Home').text,
          away_team_id: xml.css('AwayID').text,
          away_team: xml.css('Away').text,
          spread: xml.css('Spread_Current Spread').text
        })
      end
    end
  end
end
