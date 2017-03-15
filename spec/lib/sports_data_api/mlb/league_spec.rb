require 'spec_helper'

describe SportsDataApi::Mlb::League, vcr: {
  cassette_name: 'sports_data_api_mlb_league',
  record: :new_episodes,
  match_requests_on: [:path]
} do
  subject do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.leagues.first
  end

  it 'parses data and each division' do
    expect(subject[:id]).to eq '2ea6efe7-2e21-4f29-80a2-0a24ad1f5f85'
    expect(subject[:name]).to eq 'American League'
    expect(subject[:divisions].count).to eq 3
    expect(subject[:divisions].first)
      .to be_instance_of SportsDataApi::Mlb::Division
  end
end

