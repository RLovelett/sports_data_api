require 'spec_helper'

describe SportsDataApi::Nfl::Venue, vcr: {
    cassette_name: 'sports_data_api_nfl_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.access_level = 't'
    SportsDataApi.key = api_key
    SportsDataApi::Nfl.weekly(2011, :PST, 4)
  end
  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.venue }
    its(:id) { should eq '6ed18563-53e0-46c2-a91d-12d73a16456d' }
    its(:name) { should eq 'Lucas Oil Stadium' }
    its(:address) { should eq '500 S. Capitol Avenue' }
    its(:city) { should eq 'Indianapolis' }
    its(:state) { should eq 'IN' }
    its(:zip) { '46225' }
    its(:country) { should eq 'US' }
    its(:capacity) { should eq '67000' }
    its(:surface) { should eq 'artificial' }
    its(:type) { should eq 'retractable_dome' }
  end
end