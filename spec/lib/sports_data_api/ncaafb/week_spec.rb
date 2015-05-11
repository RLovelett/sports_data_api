require 'spec_helper'

describe SportsDataApi::Ncaafb::Week, vcr: {
    cassette_name: 'sports_data_api_nfl_week',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
    let(:season) do
      SportsDataApi.set_access_level(:ncaafb, 't')
      SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
      SportsDataApi::Ncaafb.schedule(2014, :REG)
    end
    subject { season.weeks.first }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Week) }
    its(:year) { should eq 2014 }
    its(:season) { should eq :REG }
    its(:number) { should eq 1 }
    its(:games) { should have(123).games }
  end
end