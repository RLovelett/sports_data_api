require 'spec_helper'

describe SportsDataApi::Nhl::Player, vcr: {
    cassette_name: 'sports_data_api_nhl_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'trial')
  end
  context 'when from team_roster' do
    let(:roster) { SportsDataApi::Nhl.team_roster('4416091c-0f24-11e2-8525-18a905767e44') }
    let(:players) { roster.players }

    context 'when skater' do
      it 'parses out the data' do
        player = players.find do |x|
          x.player[:id] == '431e124a-0f24-11e2-8525-18a905767e44'
        end
        expect(player[:status]).to eq 'ACT'
        expect(player[:full_name]).to eq 'Zach Parise'
        expect(player[:first_name]).to eq 'Zach'
        expect(player[:last_name]).to eq 'Parise'
        expect(player[:abbr_name]).to eq 'Z.Parise'
        expect(player[:height]).to eq 71
        expect(player[:weight]).to eq 196
        expect(player[:position]).to eq 'F'
        expect(player[:primary_position]).to eq 'LW'
        expect(player[:jersey_number]).to eq '11'
        expect(player[:experience]).to eq '12'
        expect(player[:college]).to eq 'North Dakota'
        expect(player[:birth_place]).to eq 'Minneapolis, MN, USA'
        expect(player[:birthdate]).to eq '1984-07-28'
        expect(player[:updated]).to eq '2018-02-08T20:58:31+00:00'
        expect(player[:reference]).to eq '8470610'
        expect(player.stats).to be_nil
      end
    end

    context 'when goalie' do
      it 'parses out the data' do
        player = players.find do |x|
          x.player[:id] == '42b65a49-0f24-11e2-8525-18a905767e44'
        end
        expect(player[:status]).to eq 'ACT'
        expect(player[:full_name]).to eq 'Devan Dubnyk'
        expect(player[:first_name]).to eq 'Devan'
        expect(player[:last_name]).to eq 'Dubnyk'
        expect(player[:abbr_name]).to eq 'D.Dubnyk'
        expect(player[:height]).to eq 78
        expect(player[:weight]).to eq 213
        expect(player[:position]).to eq 'G'
        expect(player[:primary_position]).to eq 'G'
        expect(player[:jersey_number]).to eq '40'
        expect(player[:experience]).to eq '8'
        expect(player[:college]).to be_nil
        expect(player[:birth_place]).to eq 'Regina, SK, CAN'
        expect(player[:birthdate]).to eq '1986-05-04'
        expect(player[:updated]).to eq '2017-10-05T19:42:04+00:00'
        expect(player[:reference]).to eq '8471227'
        expect(player.stats).to be_nil
      end
    end
  end

  context 'when from .game_summary' do
    let(:game_summary) { SportsDataApi::Nhl.game_summary('af285aa3-3d80-4051-9449-5b58e5985a4e') }
    let(:team) { game_summary.home_team }
    let(:players) { team.players }

    context 'when skater' do
      it 'parses out the data' do
        player = players.find do |x|
          x.player[:id] == '431e124a-0f24-11e2-8525-18a905767e44'
        end
        expect(player[:status]).to be_nil
        expect(player[:full_name]).to eq 'Zach Parise'
        expect(player[:first_name]).to eq 'Zach'
        expect(player[:last_name]).to eq 'Parise'
        expect(player[:position]).to eq 'F'
        expect(player[:primary_position]).to eq 'LW'
        expect(player[:jersey_number]).to eq '11'
        expect(player[:starter]).to eq true
        expect(player[:played]).to eq true
        expect(player.stats).to be_a SportsDataApi::MergedStats
        expect(player.stats[:total_goals]).to eq 0
        expect(player.stats[:total_assists]).to eq 1
        expect(player.stats[:total_penalties]).to eq 1
        expect(player.stats[:total_penalty_minutes]).to eq 2
        expect(player.stats[:total_shots]).to eq 2
        expect(player.stats[:total_blocked_att]).to eq 0
        expect(player.stats[:total_missed_shots]).to eq 2
        expect(player.stats[:total_hits]).to eq 1
        expect(player.stats[:total_giveaways]).to eq 0
        expect(player.stats[:total_takeaways]).to eq 2
        expect(player.stats[:total_blocked_shots]).to eq 2
        expect(player.stats[:total_faceoffs_won]).to eq 0
        expect(player.stats[:total_faceoffs_lost]).to eq 0
        expect(player.stats[:total_plus_minus]).to eq(-1)
        expect(player.stats[:total_shooting_pct]).to eq 0
        expect(player.stats[:total_faceoff_win_pct]).to eq 0
        expect(player.stats[:total_faceoffs]).to eq 0
        expect(player.stats[:total_points]).to eq 1
        expect(player.stats[:powerplay_shots]).to eq 0
        expect(player.stats[:powerplay_goals]).to eq 0
        expect(player.stats[:powerplay_missed_shots]).to eq 0
        expect(player.stats[:powerplay_assists]).to eq 0
        expect(player.stats[:powerplay_faceoffs]).to eq 0
        expect(player.stats[:powerplay_faceoffs_won]).to eq 0
        expect(player.stats[:powerplay_faceoffs_lost]).to eq 0
        expect(player.stats[:powerplay_faceoff_win_pct]).to eq 0
        expect(player.stats[:shorthanded_shots]).to eq 0
        expect(player.stats[:shorthanded_goals]).to eq 0
        expect(player.stats[:shorthanded_missed_shots]).to eq 0
        expect(player.stats[:shorthanded_assists]).to eq 0
        expect(player.stats[:shorthanded_faceoffs]).to eq 0
        expect(player.stats[:shorthanded_faceoffs_won]).to eq 0
        expect(player.stats[:shorthanded_faceoffs_lost]).to eq 0
        expect(player.stats[:shorthanded_faceoff_win_pct]).to eq 0
        expect(player.stats[:evenstrength_shots]).to eq 2
        expect(player.stats[:evenstrength_goals]).to eq 0
        expect(player.stats[:evenstrength_missed_shots]).to eq 2
        expect(player.stats[:evenstrength_assists]).to eq 1
        expect(player.stats[:evenstrength_faceoffs]).to eq 0
        expect(player.stats[:evenstrength_faceoffs_won]).to eq 0
        expect(player.stats[:evenstrength_faceoffs_lost]).to eq 0
        expect(player.stats[:evenstrength_faceoff_win_pct]).to eq 0
        expect(player.stats[:penalty_shots]).to eq 0
        expect(player.stats[:penalty_goals]).to eq 0
        expect(player.stats[:penalty_missed_shots]).to eq 0
        expect(player.stats[:shootout_shots]).to eq 0
        expect(player.stats[:shootout_goals]).to eq 0
        expect(player.stats[:shootout_missed_shots]).to eq 0
      end
    end

    context 'when goalie' do
      it 'parses out the goaltending stats' do
        player = players.find do |x|
          x.player[:id] == '42b65a49-0f24-11e2-8525-18a905767e44'
        end
        expect(player[:status]).to be_nil
        expect(player[:full_name]).to eq 'Devan Dubnyk'
        expect(player[:first_name]).to eq 'Devan'
        expect(player[:last_name]).to eq 'Dubnyk'
        expect(player[:position]).to eq 'G'
        expect(player[:primary_position]).to eq 'G'
        expect(player[:jersey_number]).to eq '40'
        expect(player[:starter]).to eq true
        expect(player[:played]).to eq true
        expect(player.stats).to be_a SportsDataApi::MergedStats
        expect(player.stats[:total_shots_against]).to eq 17
        expect(player.stats[:total_goals_against]).to eq 3
        expect(player.stats[:total_saves]).to eq 14
        expect(player.stats[:total_credit]).to eq "win"
        expect(player.stats[:total_saves_pct]).to eq 0.824
        expect(player.stats[:powerplay_shots_against]).to eq 0
        expect(player.stats[:powerplay_goals_against]).to eq 0
        expect(player.stats[:powerplay_saves]).to eq 0
        expect(player.stats[:powerplay_saves_pct]).to eq 0
        expect(player.stats[:shorthanded_shots_against]).to eq 2
        expect(player.stats[:shorthanded_goals_against]).to eq 0
        expect(player.stats[:shorthanded_saves]).to eq 2
        expect(player.stats[:shorthanded_saves_pct]).to eq 1.0
        expect(player.stats[:evenstrength_shots_against]).to eq 15
        expect(player.stats[:evenstrength_goals_against]).to eq 3
        expect(player.stats[:evenstrength_saves]).to eq 12
        expect(player.stats[:evenstrength_saves_pct]).to eq 0.8
        expect(player.stats[:penalty_shots_against]).to eq 0
        expect(player.stats[:penalty_goals_against]).to eq 0
        expect(player.stats[:penalty_saves]).to eq 0
        expect(player.stats[:penalty_saves_pct]).to eq 0
        expect(player.stats[:shootout_shots_against]).to eq 0
        expect(player.stats[:shootout_goals_against]).to eq 0
        expect(player.stats[:shootout_saves]).to eq 0
        expect(player.stats[:shootout_saves_pct]).to eq 0
      end
    end
  end
end
