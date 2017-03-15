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
    end
  end
end
