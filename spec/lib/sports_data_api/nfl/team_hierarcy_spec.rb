require 'spec_helper'

describe SportsDataApi::Nfl::TeamHierarchy, vcr: {
    cassette_name: 'sports_data_api_nfl_team_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.key = api_key
    SportsDataApi.access_level = 't'
  end
  let(:team) { SportsDataApi::Nfl.get_teams.first }

  describe 'team' do
    it "responds to id attribute" do
      expect(team).to respond_to(:id)
      expect(team.id).not_to be nil
    end
    it "responds to name attribute" do
      expect(team).to respond_to(:name)
      expect(team.name).not_to be nil
    end
    it "responds to market attribute" do
      expect(team).to respond_to(:market)
      expect(team.market).not_to be nil
    end
  end
end
