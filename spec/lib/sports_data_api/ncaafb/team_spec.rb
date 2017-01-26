require 'spec_helper'

describe SportsDataApi::Ncaafb::Team, vcr: {
    cassette_name: 'sports_data_api_ncaafb_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:boxscore) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.boxscore(2014, :REG, 10, 'IOW', 'NW')
  end
  let(:game_statistics) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.game_statistics(2014, :REG, 10, 'IOW', 'NW')
  end

  context 'boxscore' do
    describe 'home team' do
      subject { boxscore.home_team }
      it { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
      its(:id) { should eq 'IOW' }
      its(:name) { should eq 'Hawkeyes' }
      its(:market) { should eq 'Iowa' }
      its(:remaining_challenges) { should eq 2 }
      its(:remaining_timeouts) { should eq 2 }
      its(:score) { should eq 48 }
      its(:quarters) { should have(4).scores }
      its(:quarters) { should eq [24, 14, 0, 10] }
    end

    describe 'away team' do
      subject { boxscore.away_team }
      it { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
      its(:id) { should eq 'NW' }
      its(:name) { should eq 'Wildcats' }
      its(:market) { should eq 'Northwestern' }
      its(:remaining_challenges) { should eq 2 }
      its(:remaining_timeouts) { should eq 2 }
      its(:score) { should eq 7 }
      its(:quarters) { should have(4).scores }
      its(:quarters) { should eq [0, 7, 0, 0] }
    end

    describe 'eql' do
      let(:url) { 'http://api.sportsdatallc.org/ncaafb-t1/teams/uscaa/hierarchy.json' }

      let(:team_hash) do
        str = RestClient.get(url, params: { api_key: api_key(:ncaafb) }).to_s
        teams_hash = MultiJson.load(str)
        teams_hash['conferences'][0]['teams'][0]
      end

      let(:team_1) { SportsDataApi::Ncaafb::Team.new(team_hash) }
      let(:team_2) { SportsDataApi::Ncaafb::Team.new(team_hash) }

      it { (team_1 == team_2).should eq(true) }
    end
  end

  context 'game statistics' do
    describe 'home team' do
      subject { game_statistics.home_team }
      its(:id) { should eq 'IOW' }
      its(:points) { should eq 48 }
    end

    describe 'away team' do
      subject { game_statistics.away_team }
      its(:id) { should eq 'NW' }
      its(:points) { should eq 7 }
    end
  end
end
