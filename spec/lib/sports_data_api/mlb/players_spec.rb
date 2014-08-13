require 'spec_helper'

describe SportsDataApi::Mlb::Players, vcr: {
    cassette_name: 'sports_data_api_mlb_team_roster',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:team_rosters) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.team_roster
  end

  subject { team_rosters }
  its(:count) { should eq 900 }

end
