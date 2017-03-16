require 'spec_helper'

describe SportsDataApi::Mlb::Game, vcr: {
    cassette_name: 'sports_data_api_mlb_game',
    record: :none,
    match_requests_on: [:host, :path]
} do
  context 'when fetching a game summary' do
    subject do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.game('4f46825d-8172-47bc-9f06-2a162c330ffb')
    end
    context 'parses the game' do
      it { should be_an_instance_of(SportsDataApi::Mlb::Game) }
      it 'sets the basic properties' do
        expect(subject[:id]).to eq '4f46825d-8172-47bc-9f06-2a162c330ffb'
        expect(subject[:status]).to eq 'closed'
      end
      its(:home) { should be_an_instance_of(SportsDataApi::Mlb::Team) }
      its(:away) { should be_an_instance_of(SportsDataApi::Mlb::Team) }
      its(:home_team_id) { should eq '27a59d3b-ff7c-48ea-b016-4798f560f5e1' }
      its(:away_team_id) { should eq 'd99f919b-1534-4516-8e8a-9cd106c6d8cd' }
    end
  end
  context 'when fetching a season schedule' do
    let(:schedule) do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.season_schedule(2016, :reg)
    end
    subject { schedule.first }

    context 'parses the game' do
      it { should be_an_instance_of(SportsDataApi::Mlb::Game) }
      it 'sets the basic properties' do
        expect(subject[:id]).to eq '000f209b-7132-4020-a2b6-dec9196a1802'
        expect(subject[:status]).to eq 'closed'
      end
      its(:home) { should be_an_instance_of(SportsDataApi::Mlb::Team) }
      its(:away) { should be_an_instance_of(SportsDataApi::Mlb::Team) }
      its(:home_team_id) { should eq 'c874a065-c115-4e7d-b0f0-235584fb0e6f' }
      its(:away_team_id) { should eq 'd99f919b-1534-4516-8e8a-9cd106c6d8cd' }
    end
  end
end
