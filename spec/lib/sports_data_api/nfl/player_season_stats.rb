require 'spec_helper'

describe SportsDataApi::Nfl::PlayerSeasonStats, vcr: {
    cassette_name: 'sports_data_api_nfl_player_season_stats',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.key = api_key
    SportsDataApi.access_level = 't'
  end
  let(:player_stats) { SportsDataApi::Nfl.player_season_stats("BUF", 2013, "REG") }
  subject { player_stats }
  describe 'meta methods' do
    it { should respond_to :players }
    it { subject.players.kind_of?(Array).should be true }
  end

  describe ".players" do
    it "has key id" do
      expect(subject.players.first.has_key?(:id)).to be true
    end

    it "has key stats" do
      expect(subject.players.first.has_key?(:stats)).to be true
    end
  end
end
