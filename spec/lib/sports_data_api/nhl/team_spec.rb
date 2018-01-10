require 'spec_helper'

describe SportsDataApi::Nhl::Team, vcr: {
    cassette_name: 'sports_data_api_nhl_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'trial')
  end

  context 'results from teams fetch' do
    let(:teams) { SportsDataApi::Nhl.teams }
    subject { teams.find { |t| t.alias == 'MIN' } }

    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq '4416091c-0f24-11e2-8525-18a905767e44' }
    its(:conference) { should eq 'WESTERN' }
    its(:division) { should eq 'CENTRAL' }
    its(:market) { should eq 'Minnesota' }
    its(:name) { should eq 'Wild' }
    its(:players) { should eq [] }
    its(:points) { should be_nil }
  end

  context 'results from team roster fetch' do
    let(:roster) { SportsDataApi::Nhl.team_roster('4416091c-0f24-11e2-8525-18a905767e44') }
    subject { roster }

    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq '4416091c-0f24-11e2-8525-18a905767e44' }
    its(:conference) { should eq 'WESTERN' }
    its(:division) { should eq 'CENTRAL' }
    its(:market) { should eq 'Minnesota' }
    its(:name) { should eq 'Wild' }
    its(:points) { should be_nil }
    it 'parses players' do
      expect(subject.players.count).to eq 24
      expect(subject.players.first).to be_a SportsDataApi::Nhl::Player
    end
  end

  context 'results from game_summary fetch' do
    let(:game_summary) { SportsDataApi::Nhl.game_summary('af285aa3-3d80-4051-9449-5b58e5985a4e') }
    subject { game_summary.home_team }

    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq '4416091c-0f24-11e2-8525-18a905767e44' }
    its(:conference) { should be_nil }
    its(:division) { should be_nil }
    its(:market) { should eq 'Minnesota' }
    its(:name) { should eq 'Wild' }
    its(:points) { should eq 4 }
    its(:alias) { should be_nil }

    context 'players' do
      subject { game_summary.home_team.players }
      its(:count) { should eq 22 }
    end

    context 'player' do
      let(:team) { game_summary.home_team }
      let(:players) { team.players }
      subject { players.find{ |x| x[:id] == '431e124a-0f24-11e2-8525-18a905767e44' } }
      it { should be_an_instance_of(SportsDataApi::Nhl::Player) }
      it 'should have an id' do
        expect(subject.player[:id]).to eq '431e124a-0f24-11e2-8525-18a905767e44'
      end
      it 'should have a full_name' do
        expect(subject.player[:full_name]).to eq 'Zach Parise'
      end
      it 'should have a first_name' do
        expect(subject.player[:first_name]).to eq 'Zach'
      end
      it 'should have a last_name' do
        expect(subject.player[:last_name]).to eq 'Parise'
      end
      it 'should have a position' do
        expect(subject.player[:position]).to eq 'F'
      end
      it 'should have a primary_position' do
        expect(subject.player[:primary_position]).to eq 'LW'
      end
      it 'should have a jersey_number' do
        expect(subject.player[:jersey_number]).to eq '11'
      end
      it 'should have a played' do
        expect(subject.player[:played]).to eq true
      end
      it 'should have an starter' do
        expect(subject.player[:starter]).to eq true
      end
      its(:stats){ should be_an_instance_of(SportsDataApi::MergedStats) }

      context 'stats' do
        subject { game_summary.home_team.players.first.stats }

        it 'parses the stats' do
          expect(subject[:total_goals]).to eq 0
          expect(subject[:total_assists]).to eq 1
          expect(subject[:total_penalties]).to eq 0
          expect(subject[:total_penalty_minutes]).to eq 0
          expect(subject[:total_shots]).to eq 0
          expect(subject[:total_blocked_att]).to eq 2
          expect(subject[:total_missed_shots]).to eq 0
          expect(subject[:total_hits]).to eq 0
          expect(subject[:total_giveaways]).to eq 0
          expect(subject[:total_takeaways]).to eq 0
          expect(subject[:total_blocked_shots]).to eq 0
          expect(subject[:total_faceoffs_won]).to eq 0
          expect(subject[:total_faceoffs_lost]).to eq 0
          expect(subject[:total_plus_minus]).to eq 1
          expect(subject[:total_shooting_pct]).to eq 0
          expect(subject[:total_faceoff_win_pct]).to eq 0
          expect(subject[:total_faceoffs]).to eq 0
          expect(subject[:total_points]).to eq 1
          expect(subject[:powerplay_shots]).to eq 0
          expect(subject[:powerplay_goals]).to eq 0
          expect(subject[:powerplay_missed_shots]).to eq 0
          expect(subject[:powerplay_assists]).to eq 0
          expect(subject[:powerplay_faceoffs]).to eq 0
          expect(subject[:powerplay_faceoffs_won]).to eq 0
          expect(subject[:powerplay_faceoffs_lost]).to eq 0
          expect(subject[:powerplay_faceoff_win_pct]).to eq 0
          expect(subject[:shorthanded_shots]).to eq 0
          expect(subject[:shorthanded_goals]).to eq 0
          expect(subject[:shorthanded_missed_shots]).to eq 0
          expect(subject[:shorthanded_assists]).to eq 0
          expect(subject[:shorthanded_faceoffs]).to eq 0
          expect(subject[:shorthanded_faceoffs_won]).to eq 0
          expect(subject[:shorthanded_faceoffs_lost]).to eq 0
          expect(subject[:shorthanded_faceoff_win_pct]).to eq 0
          expect(subject[:evenstrength_shots]).to eq 0
          expect(subject[:evenstrength_goals]).to eq 0
          expect(subject[:evenstrength_missed_shots]).to eq 0
          expect(subject[:evenstrength_assists]).to eq 1
          expect(subject[:evenstrength_faceoffs]).to eq 0
          expect(subject[:evenstrength_faceoffs_won]).to eq 0
          expect(subject[:evenstrength_faceoffs_lost]).to eq 0
          expect(subject[:evenstrength_faceoff_win_pct]).to eq 0
          expect(subject[:penalty_shots]).to eq 0
          expect(subject[:penalty_goals]).to eq 0
          expect(subject[:penalty_missed_shots]).to eq 0
          expect(subject[:shootout_shots]).to eq 0
          expect(subject[:shootout_goals]).to eq 0
          expect(subject[:shootout_missed_shots]).to eq 0
        end
      end
    end
  end
end
