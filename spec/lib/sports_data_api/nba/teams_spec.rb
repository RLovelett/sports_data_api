require 'spec_helper'

describe SportsDataApi::Nba::Teams, vcr: {
    cassette_name: 'sports_data_api_nba_league_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 'trial')
  end
  subject { SportsDataApi::Nba.teams }

  its(:count) { should eq 30 }
  it 'parses outs the specific team' do
    pistons = subject.find { |t| t.name == 'Pistons' }
    expect(pistons.id).to eq '583ec928-fb46-11e1-82cb-f4ce4684ea4c'
    expect(pistons.market).to eq 'Detroit'
    expect(pistons.alias).to eq 'DET'
    expect(pistons.conference).to eq 'EASTERN'
    expect(pistons.division).to eq 'CENTRAL'
    expect(pistons.venue).to be_a SportsDataApi::Nba::Venue
    expect(pistons.players).to be_empty
  end
end
