require 'spec_helper'

describe SportsDataApi::Mlb::Division, vcr: {
  cassette_name: 'sports_data_api_mlb_league',
  record: :new_episodes,
  match_requests_on: [:path]
} do
  let(:league) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.leagues.first
  end
  subject { league.divisions.first }

  it 'parses data and each team' do
    expect(subject[:id]).to eq '1d74e8e9-7faf-4cdb-b613-3944fa5aa739'
    expect(subject[:name]).to eq 'East'
    expect(subject[:teams].count).to eq 5
    team = subject[:teams].first
    expect(team).to be_instance_of SportsDataApi::Mlb::Team
    expect(team[:division_alias]).to eq 'E'
    expect(team[:division]).to eq 'East'
  end
end

