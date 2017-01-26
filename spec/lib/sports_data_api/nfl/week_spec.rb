require 'spec_helper'

describe SportsDataApi::Nfl::Week, vcr: {
    cassette_name: 'sports_data_api_nfl_week',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
    let(:season) do
      SportsDataApi.set_access_level(:nfl, 't')
      SportsDataApi.set_key(:nfl, api_key(:nfl))
      SportsDataApi::Nfl.schedule(2012, :REG)
    end
    subject { season.weeks.first }
    it { should be_an_instance_of(SportsDataApi::Nfl::Week) }
    its(:year) { should eq 2012 }
    its(:season) { should eq :REG }
    its(:number) { should eq 1 }
    its(:games) { should have(16).gamea }
  end
end
