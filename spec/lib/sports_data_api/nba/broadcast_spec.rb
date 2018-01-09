require 'spec_helper'

describe SportsDataApi::Nba::Broadcast, vcr: {
    cassette_name: 'sports_data_api_nba_broadcast',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_access_level(:nba, 'trial')
    SportsDataApi.set_key(:nba, api_key(:nba))
  end
  let(:daily_schedule) do
    SportsDataApi::Nba.daily(2013, 12, 12)
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first.broadcast }
    it 'parses the data' do
      expect(subject[:network]).to eq 'TNT'
      expect(subject[:satellite]).to eq '245'
    end
  end
end
