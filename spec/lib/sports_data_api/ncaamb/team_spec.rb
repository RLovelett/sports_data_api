require 'spec_helper'

describe SportsDataApi::Ncaamb::Team, vcr: {
    cassette_name: 'sports_data_api_ncaamb_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.teams
  end
  let(:roster) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.team_roster('c7569eae-5b93-4197-b204-6f3a62146b25')
  end
  let(:game_summary) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.game_summary('0b387f08-6c3d-4d82-987e-e0fc3ab151d6')
  end

  context 'results from teams fetch' do
    subject { teams.first }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:id) { should eq "cd34248e-6f7d-4e0a-b694-567699bd7917" }
    its(:alias) { should eq 'CBAP' }
    its(:conference) { should eq 'ACCA-IND' }
    its(:division) { should eq 'ACCA' }
    its(:market) { should eq 'Champion Baptist' }
    its(:name) { should eq 'Tigers' }
    its(:players) { should eq [] }
    its(:points) { should be_nil }
  end
  context 'results from team roster fetch' do
    subject { roster }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:id) { should eq "c7569eae-5b93-4197-b204-6f3a62146b25" }
    its(:alias) { should eq 'WIS' }
    its(:market) { should eq 'Wisconsin' }
    its(:name) { should eq 'Badgers' }
    its(:players) { should be_an_instance_of(Array) }
    its(:points) { should be_nil }
    context 'players' do
      subject { roster.players }
      its(:count) { should eq 16 }
    end
  end
  context 'results from game_summary fetch' do
    subject { game_summary.home_team }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:id) { should eq 'c7569eae-5b93-4197-b204-6f3a62146b25' }
    its(:market) { should eq 'Wisconsin' }
    its(:name) { should eq 'Badgers' }
    its(:points) { should eq 65 }
    its(:alias) { should be_nil }
    its(:conference) { should be_nil }
    its(:division) { should be_nil }
    its(:players) { should be_an_instance_of(Array) }
    
    context 'players' do
      subject { game_summary.home_team.players }
      its(:count) { should eq 16 }
    end

    context 'player' do
      subject { game_summary.home_team.players[1] }
      it { should be_an_instance_of(SportsDataApi::Ncaamb::Player) }
      it 'should have an id' do
        expect(subject.player[:id]).to eq "cfc15d5a-efc8-443a-9868-39853a28b849"
      end
      it 'should have a full_name' do
        expect(subject.player[:full_name]).to eq "Nigel Hayes"
      end
      it 'should have a first_name' do
        expect(subject.player[:first_name]).to eq "Nigel"
      end
      it 'should have a last_name' do
        expect(subject.player[:last_name]).to eq "Hayes"
      end
      it 'should have a position' do
        expect(subject.player[:position]).to eq "F"
      end
      it 'should have a primary_position' do
        expect(subject.player[:primary_position]).to eq "NA"
      end
      it 'should have a jersey_number' do
        expect(subject.player[:jersey_number]).to eq "10"
      end
      it 'should have a played' do
        expect(subject.player[:played]).to eq "true"
      end
      it 'should have an active' do
        expect(subject.player[:active]).to eq "true"
      end
      its(:stats){ should be_an_instance_of(SportsDataApi::Stats) }

      context 'stats' do
        subject { game_summary.home_team.players[1].stats.statistics }
        it 'should have minutes' do
          expect(subject[:minutes]).to eql '33:00'
        end
        it 'should have field_goals_made' do
          expect(subject[:field_goals_made]).to eql '2'
        end
        it 'should have field_goals_made' do
          expect(subject[:field_goals_att]).to eql '7'
        end
        it 'should have field_goals_pct' do
          expect(subject[:field_goals_pct]).to eql '28.6'
        end
        it 'should have two_points_made' do
          expect(subject[:two_points_made]).to eql '2'
        end
        it 'should have two_points_att' do
          expect(subject[:two_points_att]).to eql '7'
        end
        it 'should have two_points_pct' do
          expect(subject[:two_points_pct]).to eql '0.286'
        end
        it 'should have three_points_made' do
          expect(subject[:three_points_made]).to eql '0'
        end
        it 'should have three_points_att' do
          expect(subject[:three_points_att]).to eql '0'
        end
        it 'should have three_points_pct' do
          expect(subject[:three_points_pct]).to eql '0.0'
        end
        it 'should have blocked_att' do
          expect(subject[:blocked_att]).to eql '2'
        end
        it 'should have free_throws_made' do
          expect(subject[:free_throws_made]).to eql '7'
        end
        it 'should have free_throws_att' do
          expect(subject[:free_throws_att]).to eql '8'
        end
        it 'should have free_throws_pct' do
          expect(subject[:free_throws_pct]).to eql '87.5'
        end
        it 'should have offensive_rebounds' do
          expect(subject[:offensive_rebounds]).to eql '3'
        end
        it 'should have defensive_rebounds' do
          expect(subject[:defensive_rebounds]).to eql '5'
        end
        it 'should have rebounds' do
          expect(subject[:rebounds]).to eql '8'
        end
        it 'should have assists' do
          expect(subject[:assists]).to eql '2'
        end
        it 'should have turnovers' do
          expect(subject[:turnovers]).to eql '2'
        end
        it 'should have steals' do
          expect(subject[:steals]).to eql '0'
        end
        it 'should have blocks' do
          expect(subject[:blocks]).to eql '0'
        end
        it 'should have assists_turnover_ratio' do
          expect(subject[:assists_turnover_ratio]).to eql '1.0'
        end
        it 'should have personal_fouls' do
          expect(subject[:personal_fouls]).to eql '1'
        end
        it 'should have tech_fouls' do
          expect(subject[:tech_fouls]).to eql '0'
        end
        it 'should have flagrant_fouls' do
          expect(subject[:flagrant_fouls]).to eql '0'
        end
        it 'should have points' do
          expect(subject[:points]).to eql '11'
        end
      end
    end
  end
end
