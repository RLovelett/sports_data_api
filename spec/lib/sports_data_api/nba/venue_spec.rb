require 'spec_helper'

describe SportsDataApi::Nba::Venue, vcr: {
    cassette_name: 'sports_data_api_nba_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_access_level(:nba, 'trial')
    SportsDataApi.set_key(:nba, api_key(:nba))
  end

  context 'results from weekly schedule fetch' do
    let(:daily) { SportsDataApi::Nba.daily(2013, 12, 12) }
    subject { daily.first.venue }

    its(:id) { should eq '7a330bcd-ac0f-50ca-bc29-2460e5c476b3' }
    its(:name) { should eq 'Barclays Center' }
    its(:address) { should eq '620 Atlantic Avenue.' }
    its(:city) { should eq 'Brooklyn' }
    its(:state) { should eq 'NY' }
    its(:zip) { should eq '11217' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq 17732 }
  end

  context 'from teams' do
    let(:teams) { SportsDataApi::Nba.teams }
    let(:nets) { teams.find { |t| t.name == 'Nets' } }
    subject { nets.venue }

    its(:id) { should eq '7a330bcd-ac0f-50ca-bc29-2460e5c476b3' }
    its(:name) { should eq 'Barclays Center' }
    its(:address) { should eq '620 Atlantic Avenue.' }
    its(:city) { should eq 'Brooklyn' }
    its(:state) { should eq 'NY' }
    its(:zip) { should eq '11217' }
    its(:country) { should eq 'USA' }
    its(:capacity) { should eq 17732 }
  end
end
