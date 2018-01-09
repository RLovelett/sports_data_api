require 'spec_helper'

describe SportsDataApi::Nba::Game, vcr: {
    cassette_name: 'sports_data_api_nba_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 'trial')
  end

  context 'when from schedule' do
    let(:season) { SportsDataApi::Nba.schedule(2017, :REG) }
    subject { season.games.first }

    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq '4c1b49cd-e114-4936-8a81-10b238cc5d45' }
    its(:scheduled) { should eq Time.new(2017, 10, 18, 0, 0, 0, '+00:00') }
    its(:home_team_id) { should eq '583ec773-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away_team_id) { should eq '583eccfa-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Cleveland Cavaliers'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Boston Celtics'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'CLE'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'BOS'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nba::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nba::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nba::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end

  context 'when from game_summary' do
    subject { SportsDataApi::Nba.game_summary('e1dcf692-330d-46d3-8add-a241b388fbe2') }

    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq 'e1dcf692-330d-46d3-8add-a241b388fbe2' }
    its(:scheduled) { should eq Time.new(2013, 10, 30, 22, 30, 00, '-04:00') }
    its(:status) { should eq 'closed' }
    its(:quarter) { should eq 4 }
    its(:clock) { should eq '00:00' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Warriors'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Lakers'
      end
      it 'home team should have an market' do
        subject.home_team.market.should eq 'Golden State'
      end
      it 'away team should have an market' do
        subject.away_team.market.should eq 'Los Angeles'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nba::Venue) }
    its(:broadcast) { should be_nil }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nba::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end

  context 'when from daily' do
    let(:daily) { SportsDataApi::Nba.daily(2018, 1, 1) }
    subject { daily.find { |g| g.id == '3e4d96b7-ac9b-4ad9-889d-08e894d07e59' } }

    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq '3e4d96b7-ac9b-4ad9-889d-08e894d07e59' }
    its(:scheduled) { should eq Time.new(2018, 1, 2, 00, 30, 00, '+00:00') }
    its(:home_team_id) { should eq '583ecda6-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away_team_id) { should eq '583ecefd-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:status) { should eq 'closed' }
    its(:quarter) { should eq nil }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Toronto Raptors'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Milwaukee Bucks'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'TOR'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'MIL'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nba::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nba::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nba::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
end
