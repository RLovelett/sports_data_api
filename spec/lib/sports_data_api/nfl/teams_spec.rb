require 'spec_helper'

describe SportsDataApi::Nfl::Teams, vcr: {
    cassette_name: 'sports_data_api_nfl_team_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) { SportsDataApi::Nfl.teams }
  let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }

  before do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 'ot')
  end

  it 'parses out the teams' do
    expect(teams.count).to eq 32
    team = teams.detect { |x| x.id == team_id }
    expect(team).to be_a SportsDataApi::Nfl::Team
  end
end

