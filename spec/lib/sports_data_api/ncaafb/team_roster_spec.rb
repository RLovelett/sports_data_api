require 'spec_helper'

describe SportsDataApi::Ncaafb::TeamRoster, vcr: {
    cassette_name: 'sports_data_api_ncaafb_team_roster',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
  end
  let(:roster) { SportsDataApi::Ncaafb.team_roster('WIS').players.first }

  describe 'player' do
    it 'responds to id attribute' do
      expect(roster.player.has_key?(:id)).to be true
      expect(roster.player[:id]).not_to be nil
    end
    it 'responds to position attribute' do
     expect(roster.player.has_key?(:position)).to be true
      expect(roster.player[:position]).not_to be nil
    end
    it 'responds to status attribute' do
      expect(roster.player.has_key?(:status)).to be true
      expect(roster.player[:status]).not_to be nil
    end
    it 'responds to name_first attribute' do
     expect(roster.player.has_key?(:name_first)).to be true
      expect(roster.player[:name_first]).not_to be nil
    end
    it 'responds to name_last attribute' do
     expect(roster.player.has_key?(:name_last)).to be true
      expect(roster.player[:name_last]).not_to be nil
    end
    it 'responds to name_full attribute' do
     expect(roster.player.has_key?(:name_full)).to be true
      expect(roster.player[:name_full]).not_to be nil
    end
    it 'responds to height attribute' do
     expect(roster.player.has_key?(:height)).to be true
      expect(roster.player[:height]).not_to be nil
    end
    it 'responds to weight attribute' do
     expect(roster.player.has_key?(:weight)).to be true
      expect(roster.player[:weight]).not_to be nil
    end
  end
end
