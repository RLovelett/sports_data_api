require 'spec_helper'

describe SportsDataApi::Nfl::Games, vcr: {
    cassette_name: 'sports_data_api_nfl_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from weekly schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:nfl, 't')
      SportsDataApi.set_key(:nfl, api_key(:nfl))
      SportsDataApi::Nfl.weekly(2012, :PRE, 1)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Nfl::Games) }
    its(:year) { should eq 2012 }
    its(:season) { should eq :PRE }
    its(:week) { should eq 1 }
    its(:count) { should eq 16 }
  end
end
