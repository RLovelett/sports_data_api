require 'spec_helper'

describe SportsDataApi::Ncaafb::Broadcast, vcr: {
    cassette_name: 'sports_data_api_ncaafb_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi::Ncaafb.weekly(2014, :REG, 4)
  end
  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.broadcast }
    its(:network) { should eq 'ESPN' }
    its(:satellite) { should eq '206' }
    its(:internet) { should eq 'WatchESPN' }
  end
end