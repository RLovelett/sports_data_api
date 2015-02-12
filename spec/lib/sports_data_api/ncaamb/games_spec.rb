require 'spec_helper'

describe SportsDataApi::Ncaamb::Games, vcr: {
    cassette_name: 'sports_data_api_ncaamb_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:ncaamb, 't')
      SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
      SportsDataApi::Ncaamb.daily(2015, 2, 25)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Games) }
    its(:date) { should eq "2015-02-25" }
    its(:count) { should eq 51 }
  end
end
