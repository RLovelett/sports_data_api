require 'spec_helper'

describe SportsDataApi::Nhl::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nhl_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nhl, 'ot')
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi::Nhl.daily(2013, 12, 12)
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first.broadcast }
    its(:network) { should eq 'CSN-PH' }
    its(:satellite) { should eq nil }
  end
end
