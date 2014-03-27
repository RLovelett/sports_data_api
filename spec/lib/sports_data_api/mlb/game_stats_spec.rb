require 'spec_helper'

describe SportsDataApi::Mlb::Teams, vcr: {
    cassette_name: 'sports_data_api_mlb_game_stats',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:stats) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.game_statistics("000c465f-7c8c-46bb-8ea7-c26b2bc7c296")
  end

  subject { stats }
  its(:count) { should eq 32 }

end
