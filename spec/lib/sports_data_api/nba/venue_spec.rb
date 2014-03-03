require 'spec_helper'

describe SportsDataApi::Nba::Venue, vcr: {
    cassette_name: 'sports_data_api_nba_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nba, 't')
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi::Nba.daily(2013, 12, 12)
  end
  context 'results from weekly schedule fetch' do
    subject { daily_schedule.first.venue }
    its(:id) { should eq '7a330bcd-ac0f-50ca-bc29-2460e5c476b3' }
    its(:name) { should eq 'Barclays Center' }
    its(:address) { should eq '620 Atlantic Avenue.' }
    its(:city) { should eq 'Brooklyn' }
    its(:state) { should eq 'NY' }
    its(:zip) { '11217' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq '18200' }
  end
end
