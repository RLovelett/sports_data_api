require 'spec_helper'

describe SportsDataApi::Nfl::TeamSeasonStats, vcr: {
    cassette_name: 'sports_data_api_nfl_team_season_stats',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
  end
  let(:team_stats) { SportsDataApi::Nfl.team_season_stats("BUF", 2013, "REG") }
  subject { team_stats }
  describe 'meta methods' do
    it { should respond_to :id }
    it { should respond_to :stats }
    it { subject.stats.kind_of?(Array).should be true }
  end
end
