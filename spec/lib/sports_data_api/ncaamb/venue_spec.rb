require 'spec_helper'

describe SportsDataApi::Ncaamb::Venue, vcr: {
    cassette_name: 'sports_data_api_ncaamb_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi::Ncaamb.daily(2015, 2, 13)
  end
  context 'results from weekly schedule fetch' do
    subject { daily_schedule.first.venue }
    its(:id) { should eq '2e713b00-8015-42c7-813b-643f41b0d384' }
    its(:name) { should eq 'Stan Sheriff Center' }
    its(:address) { should eq '1355 Lower Campus Dr' }
    its(:city) { should eq 'Honolulu' }
    its(:state) { should eq 'HI' }
    its(:zip) { '96822' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq '10300' }
  end
end
