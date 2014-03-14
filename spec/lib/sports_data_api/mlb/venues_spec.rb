require 'spec_helper'

describe SportsDataApi::Mlb::Teams, vcr: {
    cassette_name: 'sports_data_api_mlb_venues',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:venues) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.venues
  end

  subject { venues }
  its(:count) { should eq 67 }

end
