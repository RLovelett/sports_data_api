require 'spec_helper'

describe SportsDataApi::Nba::Games, vcr: {
    cassette_name: 'sports_data_api_nba_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    before do
      SportsDataApi.set_access_level(:nba, 'trial')
      SportsDataApi.set_key(:nba, api_key(:nba))
    end
    subject { SportsDataApi::Nba.daily(2018, 1, 1) }
    it { should be_an_instance_of(SportsDataApi::Nba::Games) }
    its(:date) { should eq '2018-01-01' }
    its(:count) { should eq 4 }

    it 'is enumerable' do
      games = subject.map { |g| g.id }
      expect(games).to match_array(%w[3e4d96b7-ac9b-4ad9-889d-08e894d07e59 97f525d9-0aee-4297-9b3c-b474166d8c79 c0f6a26d-8cdc-4eaa-be07-d1eb16324b45 effe3c21-395e-42c8-a036-1e14d6b332b9])
    end
  end
end
