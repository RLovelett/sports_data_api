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
  it "grabs the status" do
    expect(stats[:status]).to eql 'closed'
  end
  it "has 25 hitting players" do
    expect(stats[:hitting].count).to eq 25
  end
  it "has 7 pitching players" do
    expect(stats[:pitching].count).to eq 7
  end

end
