require 'spec_helper'

describe SportsDataApi::Nhl::Venue, vcr: {
    cassette_name: 'sports_data_api_nhl_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nhl, 'ot')
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi::Nhl.daily(2013, 12, 12)
  end
  context 'results from weekly schedule fetch' do
    subject { daily_schedule.first.venue }
    its(:id) { should eq '0a162e5b-8d59-42d8-b173-a131bf632ffb' }
    its(:name) { should eq 'Wells Fargo Center' }
    its(:address) { should eq '3601 S. Broad St.' }
    its(:city) { should eq 'Philadelphia' }
    its(:state) { should eq 'PA' }
    its(:zip) { '19148' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq '19537' }
  end
end
