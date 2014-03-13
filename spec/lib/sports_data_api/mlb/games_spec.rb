require 'spec_helper'

describe SportsDataApi::Mlb::Games, vcr: {
    cassette_name: 'sports_data_api_mlb_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi::Mlb.daily(2014, "06", 21)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Mlb::Games) }
    its(:count) { should eq 15 }
  end
end
