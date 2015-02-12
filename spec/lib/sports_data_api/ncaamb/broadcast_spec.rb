require 'spec_helper'

describe SportsDataApi::Ncaamb::Broadcast, vcr: {
    cassette_name: 'sports_data_api_ncaamb_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi::Ncaamb.daily(2015, 2, 25)
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first.broadcast }
    its(:network) { should eq 'ESPN2' }
    its(:satellite) { should eq '209' }
  end
end