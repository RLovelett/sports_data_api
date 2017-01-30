require 'spec_helper'

describe SportsDataApi::Nfl::Team, vcr: {
    cassette_name: 'sports_data_api_nfl_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:boxscore) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
    SportsDataApi::Nfl.boxscore(2012, :REG, 9, 'IND', 'MIA')
  end
  let(:game_statistics) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
    SportsDataApi::Nfl.game_statistics(2013, :REG, 16, 'GB', 'PIT')
  end
  context 'boxscore' do
    describe 'home team' do
      subject { boxscore.home_team }
      it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
      its(:id) { should eq 'IND' }
      its(:name) { should eq 'Colts' }
      its(:market) { should eq 'Indianapolis' }
      its(:remaining_challenges) { should eq 1 }
      its(:remaining_timeouts) { should eq 2 }
      its(:score) { should eq 23 }
      its(:quarters) { should have(4).scores }
      its(:quarters) { should eq [7, 6, 7, 3] }
    end
    describe 'away team' do
      subject { boxscore.away_team }
      it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
      its(:id) { should eq 'MIA' }
      its(:name) { should eq 'Dolphins' }
      its(:market) { should eq 'Miami' }
      its(:remaining_challenges) { should eq 2 }
      its(:remaining_timeouts) { should eq 2 }
      its(:score) { should eq 20 }
      its(:quarters) { should have(4).scores }
      its(:quarters) { should eq [3, 14, 0, 3] }
    end
    describe 'eql' do
      let(:url) { 'https://api.sportsdatallc.org/nfl-t1/teams/hierarchy.json' }

      let(:dolphins_hash) do
        str = RestClient.get(url, params: { api_key: api_key(:nfl) }).to_s
        teams_hash = MultiJson.load(str)
        teams_hash['conferences'][0]['divisions'][0]['teams'][1]
      end

      let(:dolphins1) { SportsDataApi::Nfl::Team.new(dolphins_hash) }
      let(:dolphins2) { SportsDataApi::Nfl::Team.new(dolphins_hash) }

      it { (dolphins1 == dolphins2).should eq(true) }
    end
  end
  context 'game statistics' do
    describe 'home team' do
      subject { game_statistics.home_team }
      its(:id) { should eq 'GB' }
      its(:points) { should eq 31 }
    end
    describe 'away team' do
      subject { game_statistics.away_team }
      its(:id) { should eq 'PIT' }
      its(:points) { should eq 38 }
    end
  end
  describe 'venue' do
    let(:url) { 'https://api.sportsdatallc.org/nfl-t1/teams/hierarchy.json' }

    let(:dolphins_hash) do
      str = RestClient.get(url, params: { api_key: api_key(:nfl) }).to_s
      teams_hash = MultiJson.load(str)
      teams_hash['conferences'][0]['divisions'][0]['teams'][1]
    end

    let(:dolphins) { SportsDataApi::Nfl::Team.new(dolphins_hash) }
    it { dolphins.venue.should be_instance_of(SportsDataApi::Nfl::Venue)}
  end
end
