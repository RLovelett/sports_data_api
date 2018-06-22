require 'spec_helper'

describe SportsDataApi::Nfl::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nfl_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_access_level(:nfl, 'ot')
    SportsDataApi.set_key(:nfl, api_key(:nfl))
  end

  let(:base) { SportsDataApi::Nfl.schedule(2013, :REG) }
  let(:broadcast) { base.weeks.first.games.first.broadcast }

  it 'parses out the broadcast data' do
    expect(broadcast[:network]).to eq 'NBC'
  end
end
