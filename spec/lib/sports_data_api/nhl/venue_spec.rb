require 'spec_helper'

describe SportsDataApi::Nhl::Venue, vcr: {
    cassette_name: 'sports_data_api_nhl_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nhl, 'trial')
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi::Nhl.daily(2013, 12, 12)
  end
  context 'results from weekly schedule fetch' do
    subject { daily_schedule.first.venue }
    it 'parses the data' do
      expect(subject[:id]).to eq '0a162e5b-8d59-42d8-b173-a131bf632ffb'
      expect(subject[:name]).to eq 'Wells Fargo Center'
      expect(subject[:capacity]).to eq 19543
      expect(subject[:address]).to eq '3601 S. Broad St.'
      expect(subject[:city]).to eq 'Philadelphia'
      expect(subject[:state]).to eq 'PA'
      expect(subject[:zip]).to eq '19148'
      expect(subject[:country]).to eq 'USA'
      expect(subject[:time_zone]).to eq 'US/Eastern'
    end
  end
end
