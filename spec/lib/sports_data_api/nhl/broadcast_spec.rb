require 'spec_helper'

describe SportsDataApi::Nhl::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nhl_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_access_level(:nhl, 'trial')
    SportsDataApi.set_key(:nhl, api_key(:nhl))
  end
  let(:daily_schedule) do
    SportsDataApi::Nhl.daily(2013, 12, 12)
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first.broadcast }
    it 'parses the data' do
      expect(subject[:network]).to eq 'CSN-PH'
    end
  end
end
