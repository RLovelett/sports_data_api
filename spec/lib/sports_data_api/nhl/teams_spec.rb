require 'spec_helper'

describe SportsDataApi::Nhl::Teams, vcr: {
    cassette_name: 'sports_data_api_nhl_league_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'trial')
  end
  subject { SportsDataApi::Nhl.teams }

  its(:count) { should eq 31 }
  it 'parses outs the specific team' do
    team = subject.find { |t| t.name == 'Red Wings' }
    expect(team.id).to eq '44169bb9-0f24-11e2-8525-18a905767e44'
    expect(team.market).to eq 'Detroit'
    expect(team.alias).to eq 'DET'
    expect(team.conference).to eq 'EASTERN'
    expect(team.division).to eq 'ATLANTIC'
    expect(team.venue).to be_a SportsDataApi::Nhl::Venue
    expect(team.players).to be_empty
  end
end
