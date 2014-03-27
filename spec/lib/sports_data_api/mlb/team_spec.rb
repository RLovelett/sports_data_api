require 'spec_helper'

describe SportsDataApi::Mlb::Team, vcr: {
    cassette_name: 'sports_data_api_mlb_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.teams
  end

  context 'results from teams fetch' do
    subject { teams.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Team) }
    its(:id) { should eq "ef64da7f-cfaf-4300-87b0-9313386b977c" }
    its(:alias) { should eq 'LA' }
    its(:league) { should eq 'NL' }
    its(:division) { should eq 'W' }
    its(:market) { should eq 'Los Angeles' }
    its(:name) { should eq 'Dodgers' }
  end
end
