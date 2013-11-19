require 'spec_helper'

describe SportsDataApi::Nfl::TeamRoster, vcr: {
    cassette_name: 'sports_data_api_nfl_team_roster',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.key = api_key
    SportsDataApi.access_level = 't'
  end
  let(:roster) { SportsDataApi::Nfl.team_roster('MIA').players.first }

  describe 'player' do
    it "responds to id attribute" do
      expect(roster.player.has_key?(:id)).to be true
      expect(roster.player[:id]).not_to be nil
    end
    it "responds to position attribute" do
     expect(roster.player.has_key?(:position)).to be true
      expect(roster.player[:position]).not_to be nil
    end
    it "responds to status attribute" do
      expect(roster.player.has_key?(:status)).to be true
      expect(roster.player[:status]).not_to be nil
    end
  end
end
