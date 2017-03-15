require 'spec_helper'

describe SportsDataApi::Mlb, '.daily_summary', vcr: {
  cassette_name: 'sports_data_api_mlb_daily_summary',
  record: :new_episodes,
  match_requests_on: [:path]
} do
  subject do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.daily_summary(2016, 9, 24)
  end

  it 'parses data and sets games' do
    expect(subject.count).to eq 15
    expect(subject.first).to be_instance_of SportsDataApi::Mlb::Game
  end
end
