require 'spec_helper'

describe SportsDataApi::Nhl::Game, vcr: {
    cassette_name: 'sports_data_api_nhl_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'trial')
  end

  context 'when from schedule' do
    let(:season) { SportsDataApi::Nhl.schedule(2017, :REG) }
    subject { season.games.first }

    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq '6cbe1593-9d60-4a4f-89d7-8b5d88263dc3' }
    its(:scheduled) { should eq Time.new(2017, 10, 4, 23, 0, 0, '+00:00') }
    its(:home_team_id) { should eq '44180e55-0f24-11e2-8525-18a905767e44' }
    its(:away_team_id) { should eq '441730a9-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Winnipeg Jets'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Toronto Maple Leafs'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'WPG'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'TOR'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nhl::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end

  context 'when from game_summary' do
    subject { SportsDataApi::Nhl.game_summary('6d20bdbd-b5e0-46ab-8b98-45ea01ab0e2b') }

    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq '6d20bdbd-b5e0-46ab-8b98-45ea01ab0e2b' }
    its(:scheduled) { should eq Time.new(2018, 1, 1, 18, 0, 00, '+00:00') }
    its(:home_team_id) { should eq '4416d559-0f24-11e2-8525-18a905767e44' }
    its(:away_team_id) { should eq '441781b9-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:period) { should eq 4 }
    its(:clock) { should eq '00:00' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Sabres'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Rangers'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_nil }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end

  context 'when from daily' do
    let(:daily) { SportsDataApi::Nhl.daily(2018, 1, 1) }
    subject { daily.find { |g| g.id == '6d20bdbd-b5e0-46ab-8b98-45ea01ab0e2b' } }

    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq '6d20bdbd-b5e0-46ab-8b98-45ea01ab0e2b' }
    its(:scheduled) { should eq Time.new(2018, 1, 1, 18, 0, 00, '+00:00') }
    its(:home_team_id) { should eq '4416d559-0f24-11e2-8525-18a905767e44' }
    its(:away_team_id) { should eq '441781b9-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:period) { should eq nil }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Buffalo Sabres'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'New York Rangers'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'BUF'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'NYR'
      end
    end
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nhl::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
end
