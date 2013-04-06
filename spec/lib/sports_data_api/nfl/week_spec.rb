require 'spec_helper'

describe SportsDataApi::Nfl::Week, vcr: {
    cassette_name: 'sports_data_api_nfl_week',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
    let(:season) do
      SportsDataApi.access_level = 't'
      SportsDataApi.key = api_key
      SportsDataApi::Nfl.schedule(2012, :REG)
    end
    subject { season.weeks.first }
    it { should be_an_instance_of(SportsDataApi::Nfl::Week) }
    its(:number) { should eq 1 }
    its(:games) { should have(16).games }
  end
end