require 'spec_helper'

describe SportsDataApi::Nhl::Team, vcr: {
    cassette_name: 'sports_data_api_nhl_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi::Nhl.teams
  end
  let(:roster) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi::Nhl.team_roster('44151f7a-0f24-11e2-8525-18a905767e44')
  end
  let(:game_summary) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi::Nhl.game_summary('f0f7e327-3a3a-410b-be75-0956c90c4988')
  end

  context 'results from teams fetch' do
    subject { teams.first }
    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq "44151f7a-0f24-11e2-8525-18a905767e44" }
    its(:alias) { should eq 'LA' }
    its(:conference) { should eq 'WESTERN' }
    its(:division) { should eq 'PACIFIC' }
    its(:market) { should eq 'Los Angeles' }
    its(:name) { should eq 'Kings' }
    its(:players) { should eq [] }
    its(:points) { should be_nil }
  end
  context 'results from team roster fetch' do
    subject { roster }
    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq "44151f7a-0f24-11e2-8525-18a905767e44" }
    its(:alias) { should eq 'LA' }
    its(:market) { should eq 'Los Angeles' }
    its(:name) { should eq 'Kings' }
    its(:players) { should be_an_instance_of(Array) }
    its(:points) { should be_nil }
    context 'players' do
      subject { roster.players }
      its(:count) { should eq 25 }
    end
  end
  context 'results from game_summary fetch' do
    subject { game_summary.home_team }
    it { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:id) { should eq '441713b7-0f24-11e2-8525-18a905767e44' }
    its(:market) { should eq 'Montreal' }
    its(:name) { should eq 'Canadiens' }
    its(:points) { should eq 3 }
    its(:alias) { should be_nil }
    its(:conference) { should be_nil }
    its(:division) { should be_nil }
    its(:players) { should be_an_instance_of(Array) }

    context 'players' do
      subject { game_summary.home_team.players }
      its(:count) { should eq 26 }
    end

    context 'player' do
      subject { game_summary.away_team.players.first }
      it { should be_an_instance_of(SportsDataApi::Nhl::Player) }
      it 'should have an id' do
        expect(subject.player[:id]).to eq "42bf409e-0f24-11e2-8525-18a905767e44"
      end
      it 'should have a full_name' do
        expect(subject.player[:full_name]).to eq "Dave Bolland"
      end
      it 'should have a first_name' do
        expect(subject.player[:first_name]).to eq "Dave"
      end
      it 'should have a last_name' do
        expect(subject.player[:last_name]).to eq "Bolland"
      end
      it 'should have a position' do
        expect(subject.player[:position]).to eq "F"
      end
      it 'should have a primary_position' do
        expect(subject.player[:primary_position]).to eq "C"
      end
      it 'should have a jersey_number' do
        expect(subject.player[:jersey_number]).to eq "63"
      end
      it 'should have a played' do
        expect(subject.player[:played]).to eq "true"
      end
      it 'should not be scratched' do
        expect(subject.player[:scratched]).to eq nil
      end
      it 'should not have goaltending' do
        expect(subject.stats.goaltending).to eq nil
      end

      its(:stats){ should be_an_instance_of(SportsDataApi::Stats) }
      context 'stats' do
        subject { game_summary.away_team.players.first.stats.statistics }
        it 'should have goals' do
          expect(subject[:goals]).to eq '0'
        end
        it 'should have assists' do
          expect(subject[:assists]).to eq '0'
        end
        it 'should have penalties' do
          expect(subject[:penalties]).to eq '1'
        end
        it 'should have penalty_minutes' do
          expect(subject[:penalty_minutes]).to eq '2'
        end
        it 'should have shots' do
          expect(subject[:shots]).to eq '2'
        end
        it 'should have blocked_att' do
          expect(subject[:blocked_att]).to eq '1'
        end
        it 'should have missed_shots' do
          expect(subject[:missed_shots]).to eq '1'
        end
        it 'should have hits' do
          expect(subject[:hits]).to eq '4'
        end
        it 'should have blocked_att' do
          expect(subject[:giveaways]).to eq '0'
        end
        it 'should have takeaways' do
          expect(subject[:takeaways]).to eq '1'
        end
        it 'should have blocked_shots' do
          expect(subject[:blocked_shots]).to eq '1'
        end
        it 'should have faceoffs_won' do
          expect(subject[:faceoffs_won]).to eq '4'
        end
        it 'should have faceoffs_lost' do
          expect(subject[:faceoffs_lost]).to eq '4'
        end
        it 'should have winning_goal' do
          expect(subject[:winning_goal]).to be_falsy
        end
        it 'should have shooting_pct' do
          expect(subject[:shooting_pct]).to eq '0.0'
        end
        it 'should have faceoffs' do
          expect(subject[:faceoffs]).to eq '8'
        end
        it 'should have faceoff_win_pct' do
          expect(subject[:faceoff_win_pct]).to eq '50.0'
        end
        it 'should have points' do
          expect(subject[:points]).to eq '0'
        end
        it 'should have powerplay_shots' do
          expect(subject[:powerplay_shots]).to eq '0'
        end
        it 'should have powerplay_goals' do
          expect(subject[:powerplay_goals]).to eq '0'
        end
        it 'should have powerplay_missed_shots' do
          expect(subject[:powerplay_missed_shots]).to eq '0'
        end
        it 'should have powerplay_assists' do
          expect(subject[:powerplay_assists]).to eq '0'
        end
        it 'should have shorthanded_shots' do
          expect(subject[:shorthanded_shots]).to eq '0'
        end
        it 'should have shorthanded_goals' do
          expect(subject[:shorthanded_goals]).to eq '0'
        end
        it 'should have shorthanded_missed_shots' do
          expect(subject[:shorthanded_missed_shots]).to eq '0'
        end
        it 'should have shorthanded_assists' do
          expect(subject[:shorthanded_assists]).to eq '0'
        end
        it 'should have eventstrength_shots' do
          expect(subject[:evenstrength_shots]).to eq '2'
        end
        it 'should have eventstrength_goals' do
          expect(subject[:evenstrength_goals]).to eq '0'
        end
        it 'should have eventstrength_missed_shots' do
          expect(subject[:evenstrength_missed_shots]).to eq '1'
        end
        it 'should have eventstrength_assists' do
          expect(subject[:evenstrength_assists]).to eq '0'
        end
        it 'should have penalty_shots' do
          expect(subject[:penalty_shots]).to eq '0'
        end
        it 'should have penalty_goals' do
          expect(subject[:penalty_goals]).to eq '0'
        end
        it 'should have penalty_missed_shots' do
          expect(subject[:penalty_missed_shots]).to eq '0'
        end
        it 'should have shootout_shots' do
          expect(subject[:shootout_shots]).to eq '0'
        end
        it 'should have shootout_goals' do
          expect(subject[:shootout_goals]).to eq '0'
        end
        it 'should have shootout_missed_shots' do
          expect(subject[:shootout_missed_shots]).to eq '0'
        end
      end
    end

    context 'goalie' do
      subject { game_summary.away_team.players.select { |player| !player.stats.goaltending.nil? }.first.stats.goaltending }
      it 'should have goaltending' do
        expect(subject).to be_a Hash
      end
      it 'should have shots_against' do
        expect(subject[:shots_against]).to eq '37'
      end
      it 'should have goals_against' do
        expect(subject[:goals_against]).to eq '3'
      end
      it 'should have saves' do
        expect(subject[:saves]).to eq '34'
      end
      it 'should have credit' do
        expect(subject[:credit]).to eq 'win'
      end
      it 'should have shutout' do
        expect(subject[:shutout]).to be_falsy
      end
      it 'should have saves_pct' do
        expect(subject[:saves_pct]).to eq '0.919'
      end
    end
  end
end
