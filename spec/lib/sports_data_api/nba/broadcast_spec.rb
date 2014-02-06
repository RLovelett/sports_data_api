require 'spec_helper'

describe SportsDataApi::Nba::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nba_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nba, 't')
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi::Nba.daily(2013, 12, 12)
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first.broadcast }
    its(:network) { should eq 'TNT' }
    its(:satellite) { should eq '245' }
  end
end
