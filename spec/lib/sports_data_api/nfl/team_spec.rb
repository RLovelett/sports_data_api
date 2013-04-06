require 'spec_helper'

describe SportsDataApi::Nfl::Team, vcr: {
    cassette_name: 'sports_data_api_nfl_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:boxscore) do
    SportsDataApi.key = api_key
    SportsDataApi.access_level = 't'
    SportsDataApi::Nfl.boxscore(2012, :REG, 9, 'IND', 'MIA')
  end
  describe 'home team' do
    subject { boxscore.home_team }
    it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
    its(:id) { should eq 'IND' }
    its(:name) { should eq 'Colts' }
    its(:market) { should eq 'Indianapolis' }
    its(:remaining_challenges) { should eq 1 }
    its(:remaining_timeouts) { should eq 2 }
    its(:score) { should eq 23 }
    its(:quarters) { should have(4).scores }
    its(:quarters) { should eq [7, 6, 7, 3] }
  end
  describe 'away team' do
    subject { boxscore.away_team }
    it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
    its(:id) { should eq 'MIA' }
    its(:name) { should eq 'Dolphins' }
    its(:market) { should eq 'Miami' }
    its(:remaining_challenges) { should eq 2 }
    its(:remaining_timeouts) { should eq 2 }
    its(:score) { should eq 20 }
    its(:quarters) { should have(4).scores }
    its(:quarters) { should eq [3, 14, 0, 3] }
  end
end