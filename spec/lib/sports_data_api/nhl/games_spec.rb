require 'spec_helper'

describe SportsDataApi::Nhl::Games, vcr: {
    cassette_name: 'sports_data_api_nhl_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:nhl, 'trial')
      SportsDataApi.set_key(:nhl, api_key(:nhl))
      SportsDataApi::Nhl.daily(2013, 12, 12)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Nhl::Games) }
    its(:date) { should eq "2013-12-12" }
    its(:count) { should eq 11 }
  end
end
