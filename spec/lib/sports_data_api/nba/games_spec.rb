require 'spec_helper'

describe SportsDataApi::Nba::Games, vcr: {
    cassette_name: 'sports_data_api_nba_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    let(:games) do
      SportsDataApi.access_level = 't'
      SportsDataApi.set_key(:nba, api_key(:nba))
      SportsDataApi::Nba.daily(2013, 12, 12)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Nba::Games) }
    its(:date) { should eq "2013-12-12" }
    its(:count) { should eq 2 }
  end
end
