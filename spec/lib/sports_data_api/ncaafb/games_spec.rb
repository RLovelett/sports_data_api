require 'spec_helper'

describe SportsDataApi::Ncaafb::Games, vcr: {
    cassette_name: 'sports_data_api_ncaafb_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from weekly schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:ncaafb, 't')
      SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
      SportsDataApi::Ncaafb.weekly(2014, :REG, 1)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Games) }
    its(:year) { should eq 2014 }
    its(:season) { should eq :REG }
    its(:week) { should eq 1 }
    its(:count) { should eq 123 }
  end
end