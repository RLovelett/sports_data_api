require 'spec_helper'

describe SportsDataApi::Mlb::Games, vcr: {
    cassette_name: 'sports_data_api_mlb_games',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from daily schedule fetch' do
    let(:games) do
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi::Mlb.daily(2014, '04', 16)
    end
    subject { games }
    it { should be_an_instance_of(SportsDataApi::Mlb::Games) }
    its(:count) { should eq 16 }
    it "gets postponed information" do
      game = games.games[10]
      expect(game.scheduled).to eql Time.parse('2014-04-17T23:10:00Z')
      expect(game.rescheduled_reason).to eql 'postponed'
      expect(game.rescheduled_from).to eql Time.parse('2014-04-17T00:10:00Z')
    end
  end
end
