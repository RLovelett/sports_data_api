require 'spec_helper'

describe SportsDataApi::Ncaafb::Venue, vcr: {
    cassette_name: 'sports_data_api_ncaafb_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi::Ncaafb.weekly(2014, :REG, 4)
  end

  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.venue }
    its(:id) { should eq 'c63bd111-d94a-42e1-bd95-cbb74103552c' }
    its(:name) { should eq 'Bill Snyder Family Football Stadium' }
    its(:address) { should eq '1800 College Avenue' }
    its(:city) { should eq 'Manhattan' }
    its(:state) { should eq 'KS' }
    its(:zip) { '46225' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq 50000 }
    its(:surface) { should eq 'artificial' }
    its(:type) { should eq 'outdoor' }
  end
end