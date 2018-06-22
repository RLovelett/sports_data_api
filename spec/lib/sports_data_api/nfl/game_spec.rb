require 'spec_helper'

describe SportsDataApi::Nfl::Game, vcr: {
    cassette_name: 'sports_data_api_nfl_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 'ot')
  end

  describe 'game parsed from .schedule' do
    let(:base) { SportsDataApi::Nfl.schedule(2013, :REG) }
    let(:game) { base.weeks.first.games.first }

    it 'parses each field' do
      expect(game.id).to eq '05e9531d-e7e7-45c8-ae5a-91a2eb8acfa8'
      expect(game.status).to eq 'closed'
      expect(game.quarter).to be_nil
      expect(game.clock).to be_nil
      expect(game.year).to eq 2013
      expect(game.season).to eq :REG
      expect(game.week).to eq 1
      expect(game.home_team_id).to eq 'e627eec7-bbae-4fa4-8e73-8e1d6bc5c060'
      expect(game.home_team).to be_a SportsDataApi::Nfl::Team
      expect(game.away_team_id).to eq '04aa1c9d-66da-489d-b16a-1dee3f2eec4d'
      expect(game.away_team).to be_a SportsDataApi::Nfl::Team
      expect(game.scheduled).to eq Time.parse('2013-09-09T00:30:42+00:00')
      expect(game.venue).to be_a SportsDataApi::Nfl::Venue
      expect(game.broadcast).to be_a SportsDataApi::Nfl::Broadcast
    end
  end

  describe 'game parsed from .boxscore' do
    let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
    let(:game) { SportsDataApi::Nfl.boxscore(game_id) }

    it 'parses each field' do
      expect(game.id).to eq game_id
      expect(game.status).to eq 'closed'
      expect(game.quarter).to eq 4
      expect(game.clock).to eq '00:00'
      expect(game.year).to eq 2012
      expect(game.season).to eq :REG
      expect(game.week).to eq 9
      expect(game.home_team_id).to eq '82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9'
      expect(game.home_team).to be_a SportsDataApi::Nfl::Team
      expect(game.away_team_id).to eq '4809ecb0-abd3-451d-9c4a-92a90b83ca06'
      expect(game.away_team).to be_a SportsDataApi::Nfl::Team
      expect(game.scheduled).to eq Time.parse('2012-11-04T18:02:34+00:00')
      expect(game.venue).to be_a SportsDataApi::Nfl::Venue
      expect(game.broadcast).to be_nil
    end
  end

  describe 'game parsed from .game_roster' do
    let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
    let(:game) { SportsDataApi::Nfl.game_roster(game_id) }

    it 'parses each field' do
      expect(game.id).to eq game_id
      expect(game.status).to eq 'closed'
      expect(game.quarter).to eq 4
      expect(game.clock).to eq '00:00'
      expect(game.year).to eq 2012
      expect(game.season).to eq :REG
      expect(game.week).to eq 9
      expect(game.home_team_id).to eq '82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9'
      expect(game.home_team).to be_a SportsDataApi::Nfl::Team
      expect(game.away_team_id).to eq '4809ecb0-abd3-451d-9c4a-92a90b83ca06'
      expect(game.away_team).to be_a SportsDataApi::Nfl::Team
      expect(game.scheduled).to eq Time.parse('2012-11-04T18:02:34+00:00')
      expect(game.venue).to be_a SportsDataApi::Nfl::Venue
      expect(game.broadcast).to be_nil
    end
  end

  describe 'game parsed from .game_statistics' do
    let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
    let(:game) { SportsDataApi::Nfl.game_statistics(game_id) }

    it 'parses each field' do
      expect(game.id).to eq game_id
      expect(game.status).to eq 'closed'
      expect(game.quarter).to eq 4
      expect(game.clock).to eq '00:00'
      expect(game.year).to eq 2012
      expect(game.season).to eq :REG
      expect(game.week).to eq 9
      expect(game.home_team_id).to eq '82cf9565-6eb9-4f01-bdbd-5aa0d472fcd9'
      home_team = game.home_team
      expect(home_team).to be_a SportsDataApi::Nfl::Team
      expect(home_team.players.first.stats).not_to be_nil
      expect(game.away_team_id).to eq '4809ecb0-abd3-451d-9c4a-92a90b83ca06'
      away_team = game.away_team
      expect(away_team).to be_a SportsDataApi::Nfl::Team
      expect(away_team.players.first.stats).not_to be_nil
      expect(game.scheduled).to eq Time.parse('2012-11-04T18:02:34+00:00')
      expect(game.venue).to be_a SportsDataApi::Nfl::Venue
      expect(game.broadcast).to be_nil
    end
  end
end
