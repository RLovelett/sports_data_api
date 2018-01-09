require 'spec_helper'

describe SportsDataApi::Nba::Player, vcr: {
    cassette_name: 'sports_data_api_nba_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 'trial')
  end
  context 'when from team_roster' do
    let(:roster) { SportsDataApi::Nba.team_roster('583ec825-fb46-11e1-82cb-f4ce4684ea4c') }
    let(:players) { roster.players }
    it 'parses out the data' do
      player = players.find do |x|
        x.player[:id] == '8ec91366-faea-4196-bbfd-b8fab7434795'
      end
      expect(player[:status]).to eq 'ACT'
      expect(player[:full_name]).to eq 'Stephen Curry'
      expect(player[:first_name]).to eq 'Stephen'
      expect(player[:last_name]).to eq 'Curry'
      expect(player[:abbr_name]).to eq 'S.Curry'
      expect(player[:height]).to eq 75
      expect(player[:weight]).to eq 190
      expect(player[:position]).to eq 'G'
      expect(player[:primary_position]).to eq 'PG'
      expect(player[:jersey_number]).to eq '30'
      expect(player[:experience]).to eq '8'
      expect(player[:college]).to eq 'Davidson'
      expect(player[:birth_place]).to eq 'Akron, OH, USA'
      expect(player[:birthdate]).to eq '1988-03-14'
      expect(player[:updated]).to eq '2017-10-17T19:37:08+00:00'
      expect(player[:reference]).to eq '201939'
      expect(player.stats).to be_nil
    end
  end

  context 'when from .game_summary' do
    let(:game_summary) { SportsDataApi::Nba.game_summary('e1dcf692-330d-46d3-8add-a241b388fbe2') }
    let(:team) { game_summary.home_team }
    let(:players) { team.players }

    it 'parses out the data' do
      player = players.find do |x|
        x.player[:id] == '8ec91366-faea-4196-bbfd-b8fab7434795'
      end
      expect(player[:status]).to be_nil
      expect(player[:full_name]).to eq 'Stephen Curry'
      expect(player[:first_name]).to eq 'Stephen'
      expect(player[:last_name]).to eq 'Curry'
      expect(player[:position]).to eq 'G'
      expect(player[:primary_position]).to eq 'PG'
      expect(player[:jersey_number]).to eq '30'
      expect(player[:starter]).to eq true
      expect(player[:active]).to eq true
      expect(player.stats).to be_a SportsDataApi::Nba::Stats
      expect(player.stats[:minutes]).to eq "23:57"
      expect(player.stats[:field_goals_made]).to eq 4
      expect(player.stats[:field_goals_att]).to eq 10
      expect(player.stats[:field_goals_pct]).to eq 40.0
      expect(player.stats[:three_points_made]).to eq 2
      expect(player.stats[:three_points_att]).to eq 5
      expect(player.stats[:three_points_pct]).to eq 40.0
      expect(player.stats[:two_points_made]).to eq 2
      expect(player.stats[:two_points_att]).to eq 5
      expect(player.stats[:two_points_pct]).to eq 40.0
      expect(player.stats[:blocked_att]).to eq 0
      expect(player.stats[:free_throws_made]).to eq 0
      expect(player.stats[:free_throws_att]).to eq 0
      expect(player.stats[:free_throws_pct]).to eq 0.0
      expect(player.stats[:offensive_rebounds]).to eq 0
      expect(player.stats[:defensive_rebounds]).to eq 4
      expect(player.stats[:rebounds]).to eq 4
      expect(player.stats[:assists]).to eq 6
      expect(player.stats[:turnovers]).to eq 1
      expect(player.stats[:steals]).to eq 1
      expect(player.stats[:blocks]).to eq 0
      expect(player.stats[:assists_turnover_ratio]).to eq 6.0
      expect(player.stats[:personal_fouls]).to eq 4
      expect(player.stats[:tech_fouls]).to eq 0
      expect(player.stats[:flagrant_fouls]).to eq 0
      expect(player.stats[:pls_min]).to eq 28
      expect(player.stats[:points]).to eq 10
      expect(player.stats[:double_double]).to eq false
      expect(player.stats[:triple_double]).to eq false
      expect(player.stats[:effective_fg_pct]).to eq 50.0
      expect(player.stats[:efficiency]).to eq 10
      expect(player.stats[:efficiency_game_score]).to eq 8.4
      expect(player.stats[:points_in_paint]).to eq 0
      expect(player.stats[:points_in_paint_att]).to eq 0
      expect(player.stats[:points_in_paint_made]).to eq 0
      expect(player.stats[:points_in_paint_pct]).to eq 0.0
      expect(player.stats[:true_shooting_att]).to eq 10.0
      expect(player.stats[:true_shooting_pct]).to eq 50.0
      expect(player.stats[:fouls_drawn]).to eq 0
      expect(player.stats[:offensive_fouls]).to eq 0
      expect(player.stats[:points_off_turnovers]).to eq 0
      expect(player.stats[:second_chance_pts]).to eq 0
    end
  end
end
