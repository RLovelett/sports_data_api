require 'spec_helper'

describe SportsDataApi::Mlb, '.season_summary', vcr: {
  cassette_name: 'sports_data_api_mlb_season_schedule',
  record: :none,
  match_requests_on: [:path]
} do
  subject do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.season_schedule(2016, :reg)
  end

  it 'parses the scheduled games' do
    expect(subject.count).to eq 2431
    expect(subject.first).to be_instance_of(SportsDataApi::Mlb::Game)
  end
end
