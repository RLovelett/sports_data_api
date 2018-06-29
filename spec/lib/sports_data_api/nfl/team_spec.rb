require 'spec_helper'

describe SportsDataApi::Nfl::Team, vcr: {
    cassette_name: 'sports_data_api_nfl_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }

  before do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 'ot')
  end

  describe 'when team comes from .schedule' do
    let(:base) { SportsDataApi::Nfl.schedule(2012, :REG) }

    context 'parses the home team' do
      let(:team) { base.weeks.first.games.first.home_team }

      it 'parses the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '6680d28d-d4d2-49f6-aace-5292d3ec02c2'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'KC'
        expect(team.name).to eq 'Kansas City Chiefs'
        expect(team.market).to be_nil
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to be_nil
        expect(team.points).to be_nil
        expect(team.players).to be_empty
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end

    context 'parses the away team' do
      let(:team) { base.weeks.first.games.first.away_team }

      it 'parses the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq 'e6aa13a4-0055-48a9-bc41-be28dc106929'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'ATL'
        expect(team.name).to eq 'Atlanta Falcons'
        expect(team.market).to be_nil
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to be_nil
        expect(team.points).to be_nil
        expect(team.players).to be_empty
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end
  end

  describe 'when team comes from .boxscore' do
    let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
    let(:base) { SportsDataApi::Nfl.boxscore(game_id) }

    context 'when home team' do
      let(:team) { base.home_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'IND'
        expect(team.name).to eq 'Colts'
        expect(team.market).to eq 'Indianapolis'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to eq 1
        expect(team.points).to eq 23
        expect(team.players).to be_empty
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end

    context 'when away team' do
      let(:team) { base.away_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '4809ecb0-abd3-451d-9c4a-92a90b83ca06'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'MIA'
        expect(team.name).to eq 'Dolphins'
        expect(team.market).to eq 'Miami'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to eq 0
        expect(team.points).to eq 20
        expect(team.players).to be_empty
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end
  end

  describe 'when team comes from .game_roster' do
    let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
    let(:base) { SportsDataApi::Nfl.game_roster(game_id) }

    context 'when home team' do
      let(:team) { base.home_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'IND'
        expect(team.name).to eq 'Colts'
        expect(team.market).to eq 'Indianapolis'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to be_nil
        expect(team.points).to be_nil
        players = team.players
        expect(players.size).to eq 53
        expect(players.map(&:class).uniq).to eq [SportsDataApi::Nfl::Player]
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end

    context 'when away team' do
      let(:team) { base.away_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '4809ecb0-abd3-451d-9c4a-92a90b83ca06'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'MIA'
        expect(team.name).to eq 'Dolphins'
        expect(team.market).to eq 'Miami'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to be_nil
        expect(team.points).to be_nil
        players = team.players
        expect(players.size).to eq 53
        expect(players.map(&:class).uniq).to eq [SportsDataApi::Nfl::Player]
        expect(team.statistics).to be_nil
        expect(team.venue).to be_nil
      end
    end
  end

  describe 'when team comes from .team_roster' do
    let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
    let(:team) { SportsDataApi::Nfl.team_roster(team_id) }

    it 'parses out the data' do
      expect(team).to be_a SportsDataApi::Nfl::Team
      expect(team.id).to eq team_id
      expect(team.conference).to eq 'NFC'
      expect(team.division).to eq 'NFC North'
      expect(team.alias).to eq 'MIN'
      expect(team.name).to eq 'Vikings'
      expect(team.market).to eq 'Minnesota'
      expect(team.remaining_challenges).to be_nil
      expect(team.remaining_timeouts).to be_nil
      expect(team.points).to be_nil
      players = team.players
      expect(players.size).to eq 90
      expect(players.map(&:class).uniq).to eq [SportsDataApi::Nfl::Player]
      expect(team.statistics).to be_nil
      expect(team.venue).to be_a SportsDataApi::Nfl::Venue
    end
  end

  describe 'when team comes from .teams' do
    let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
    let(:base) { SportsDataApi::Nfl.teams }
    let(:team) { base.teams.detect { |t| t.id == team_id } }

    it 'parses out the data' do
      expect(team).to be_a SportsDataApi::Nfl::Team
      expect(team.id).to eq team_id
      expect(team.conference).to eq 'NFC'
      expect(team.division).to eq 'NFC North'
      expect(team.alias).to eq 'MIN'
      expect(team.name).to eq 'Vikings'
      expect(team.market).to eq 'Minnesota'
      expect(team.remaining_challenges).to be_nil
      expect(team.remaining_timeouts).to be_nil
      expect(team.points).to be_nil
      expect(team.players).to be_empty
      expect(team.statistics).to be_nil
      expect(team.venue).to be_a SportsDataApi::Nfl::Venue
    end
  end

  describe 'when team comes from .game_statistics' do
    let(:game_id) { 'cd2bd061-0acd-4f3b-97e4-9b2ca04f99b1' }
    let(:base) { SportsDataApi::Nfl.game_statistics(game_id) }

    context 'when home team' do
      let(:team) { base.home_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq 'cb2f9f1f-ac67-424e-9e72-1475cb0ed398'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'PIT'
        expect(team.name).to eq 'Steelers'
        expect(team.market).to eq 'Pittsburgh'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to eq 0
        expect(team.points).to eq 24
        players = team.players
        expect(players.size).to eq 33
        player = players.detect { |p| p[:name] == "Le'Veon Bell" }
        expect(player.stats[:rushing_yards]).to eq 117
        expect(player.stats[:receiving_yards]).to eq 48
        expect(player.stats[:rushing_touchdowns]).to eq 1
        expect(team.statistics).to be_a Hash
        expect(team.venue).to be_nil
      end
    end

    context 'when away team' do
      let(:team) { base.away_team }

      it 'parses out the data' do
        expect(team).to be_a SportsDataApi::Nfl::Team
        expect(team.id).to eq '97354895-8c77-4fd4-a860-32e62ea7382a'
        expect(team.conference).to be_nil
        expect(team.division).to be_nil
        expect(team.alias).to eq 'NE'
        expect(team.name).to eq 'Patriots'
        expect(team.market).to eq 'New England'
        expect(team.remaining_challenges).to be_nil
        expect(team.remaining_timeouts).to eq 2
        expect(team.points).to eq 27
        players = team.players
        expect(players.size).to eq 35
        player1 = players.detect { |p| p[:name] == 'Tom Brady' }
        expect(player1.stats[:extra_points_pass_attempts]).to eq 1
        expect(player1.stats[:extra_points_pass_successes]).to eq 1
        expect(player1.stats[:passing_yards]).to eq 298
        player2 = players.detect { |p| p[:name] == 'Rob Gronkowski' }
        expect(player2.stats[:extra_points_receive_attempts]).to eq 1
        expect(player2.stats[:extra_points_receive_successes]).to eq 1
        player3 = players.detect { |p| p[:name] == 'Stephen Gostkowski' }
        expect(player3.stats[:extra_points_kicks_attempts]).to eq 2
        expect(player3.stats[:extra_points_kicks_made]).to eq 1
        expect(team.statistics).to be_a Hash
        expect(team.venue).to be_nil
      end
    end
  end
end
