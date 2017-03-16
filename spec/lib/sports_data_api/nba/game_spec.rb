require 'spec_helper'

describe SportsDataApi::Nba::Game, vcr: {
    cassette_name: 'sports_data_api_nba_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 't')
    SportsDataApi::Nba.schedule(2013, :REG)
  end
  let(:game_summary) do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 't')
    SportsDataApi::Nba.game_summary('e1dcf692-330d-46d3-8add-a241b388fbe2')
  end
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nba, 't')
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi::Nba.daily(2013, 12, 12)
  end
  context 'results from schedule fetch' do
    subject { season.games.first }
    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq '0b3d21c7-c13f-4ee8-8d9d-4f334754c7e4' }
    its(:scheduled) { should eq Time.new(2013, 10, 29, 19, 00, 00, '-04:00') }
    its(:home) { should eq '583ec7cd-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away) { should eq '583ed157-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:home_team_id) { should eq '583ec7cd-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away_team_id) { should eq '583ed157-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Indiana Pacers'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Orlando Magic'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'IND'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'ORL'
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
  context 'results from game_summary fetch' do
    subject { game_summary }
    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq 'e1dcf692-330d-46d3-8add-a241b388fbe2' }
    its(:scheduled) { should eq Time.new(2013, 10, 30, 22, 30, 00, '-04:00') }
    its(:home) { should eq '583ec825-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away) { should eq '583ecae2-fb46-11e1-82cb-f4ce4684ea4c' }
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
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nba::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nba::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first }
    it { should be_an_instance_of(SportsDataApi::Nba::Game) }
    its(:id) { should eq '9dbf017d-250d-4ee7-8b3b-00dfa2f9e8b7' }
    its(:scheduled) { should eq Time.new(2013, 12, 12, 20, 00, 00, '-05:00') }
    its(:home) { should eq '583ec9d6-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away) { should eq '583ecdfb-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:home_team_id) { should eq '583ec9d6-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:away_team_id) { should eq '583ecdfb-fb46-11e1-82cb-f4ce4684ea4c' }
    its(:status) { should eq 'closed' }
    its(:quarter) { should eq nil }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nba::Team) }
    describe 'parsing team info' do
      it 'home team should have an name' do
        subject.home_team.name.should eq 'Brooklyn Nets'
      end
      it 'away team should have an name' do
        subject.away_team.name.should eq 'Los Angeles Clippers'
      end
      it 'home team should have an alias' do
        subject.home_team.alias.should eq 'BKN'
      end
      it 'away team should have an alias' do
        subject.away_team.alias.should eq 'LAC'
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
