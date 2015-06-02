require 'spec_helper'

describe SportsDataApi::Nfl::Game, vcr: {
    cassette_name: 'sports_data_api_nfl_play_by_play',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:play_by_play) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
    SportsDataApi::Nfl.play_by_play(2012, :REG, 1, 'NYG', 'DAL')
  end

  context 'results from schedule fetch' do
    subject { play_by_play }
    it { should be_an_instance_of(SportsDataApi::Nfl::PlayByPlay) }
    its(:id) { should eq '8c0bce5a-7ca2-41e5-9838-d1b8c356ddc3' }
    its(:scheduled) { should eq Time.new(2012, 9, 5, 19, 30, 00, '-05:00') }
    its(:home) { should eq 'NYG' }
    its(:away) { should eq 'DAL' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
  end
end
