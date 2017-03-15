require 'spec_helper'

describe SportsDataApi::Mlb::MergedStats, vcr: {
  cassette_name: 'sports_data_api_mlb_player',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  let(:game) {
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.game('4f46825d-8172-47bc-9f06-2a162c330ffb')
  }

  context 'when fielding' do
    let(:player) do
      game.away.players.find do |p|
        p[:first_name] == 'Elvis' && p[:last_name] == 'Andrus'
      end
    end
    subject { player.statistics.fielding }

    it 'parses out fielding stats' do
      expect(subject).to be_instance_of SportsDataApi::Mlb::MergedStats
      expect(subject[:po]).to eq 1.0
      expect(subject[:a]).to eq 2.0
      expect(subject[:dp]).to eq 0.0
      expect(subject[:tp]).to eq 0.0
      expect(subject[:error]).to eq 0.0
      expect(subject[:tc]).to eq 3.0
      expect(subject[:fpct]).to eq 1.0
      expect(subject[:c_wp]).to eq 0.0
      expect(subject[:pb]).to eq 0.0
      expect(subject[:rf]).to eq 3.0
      expect(subject[:errors_throwing]).to eq 0
      expect(subject[:errors_fielding]).to eq 0
      expect(subject[:errors_interference]).to eq 0
      expect(subject[:errors_total]).to eq 0
      expect(subject[:games_start]).to eq 1
      expect(subject[:games_play]).to eq 1
      expect(subject[:games_finish]).to eq 0
      expect(subject[:games_complete]).to eq 0
    end
  end

  context 'when hitter' do
    let(:player) do
      game.away.players.find do |p|
        p[:first_name] == 'Elvis' && p[:last_name] == 'Andrus'
      end
    end
    subject { player.statistics.hitting }

    it 'parses out hitting stats' do
      expect(subject).to be_instance_of SportsDataApi::Mlb::MergedStats
      expect(subject[:ab]).to eq 4.0
      expect(subject[:lob]).to eq 1.0
      expect(subject[:rbi]).to eq 4.0
      expect(subject[:abhr]).to eq 2.0
      expect(subject[:abk]).to eq 0.0
      expect(subject[:bip]).to eq 2.0
      expect(subject[:babip]).to eq 0.0
      expect(subject[:bbk]).to eq 0.0
      expect(subject[:bbpa]).to eq 0.0
      expect(subject[:iso]).to eq 1.5
      expect(subject[:obp]).to eq 0.5
      expect(subject[:ops]).to eq 2.5
      expect(subject[:seca]).to eq 1.5
      expect(subject[:slg]).to eq 2.0
      expect(subject[:xbh]).to eq 2.0
      expect(subject[:pitch_count]).to eq 16.0
      expect(subject[:lob_risp_2out]).to eq 0.0
      expect(subject[:team_lob]).to eq 0.0
      expect(subject[:ab_risp]).to eq 2.0
      expect(subject[:hit_risp]).to eq 1.0
      expect(subject[:rbi_2out]).to eq 2.0
      expect(subject[:linedrive]).to eq 1.0
      expect(subject[:groundball]).to eq 1.0
      expect(subject[:popup]).to eq 0.0
      expect(subject[:flyball]).to eq 2.0
      expect(subject[:ap]).to eq 4.0
      expect(subject[:avg]).to eq 0.5
      expect(subject[:gofo]).to eq 1.0
      expect(subject[:onbase_s]).to eq 0
      expect(subject[:onbase_d]).to eq 0
      expect(subject[:onbase_t]).to eq 0
      expect(subject[:onbase_hr]).to eq 2
      expect(subject[:onbase_tb]).to eq 8
      expect(subject[:onbase_bb]).to eq 0
      expect(subject[:onbase_ibb]).to eq 0
      expect(subject[:onbase_hbp]).to eq 0
      expect(subject[:onbase_fc]).to eq 0
      expect(subject[:onbase_roe]).to eq 0
      expect(subject[:onbase_h]).to eq 2
      expect(subject[:onbase_cycle]).to eq 0
      expect(subject[:runs_total]).to eq 2
      expect(subject[:outcome_klook]).to eq 1
      expect(subject[:outcome_kswing]).to eq 0
      expect(subject[:outcome_ktotal]).to eq 1
      expect(subject[:outcome_ball]).to eq 4
      expect(subject[:outcome_iball]).to eq 0
      expect(subject[:outcome_dirtball]).to eq 2
      expect(subject[:outcome_foul]).to eq 5
      expect(subject[:outs_po]).to eq 0
      expect(subject[:outs_fo]).to eq 1
      expect(subject[:outs_fidp]).to eq 0
      expect(subject[:outs_lo]).to eq 0
      expect(subject[:outs_lidp]).to eq 0
      expect(subject[:outs_go]).to eq 1
      expect(subject[:outs_gidp]).to eq 0
      expect(subject[:outs_klook]).to eq 0
      expect(subject[:outs_kswing]).to eq 0
      expect(subject[:outs_ktotal]).to eq 0
      expect(subject[:outs_sacfly]).to eq 0
      expect(subject[:outs_sachit]).to eq 0
      expect(subject[:steal_caught]).to eq 0
      expect(subject[:steal_stolen]).to eq 0
      expect(subject[:steal_pickoff]).to eq 0
      expect(subject[:steal_pct]).to eq 0.0
      expect(subject[:games_start]).to eq 1
      expect(subject[:games_play]).to eq 1
      expect(subject[:games_finish]).to eq 0
      expect(subject[:games_complete]).to eq 1
    end
  end

  context 'when pitcher' do
    let(:player) do
      game.away.players.find do |p|
        p[:first_name] == 'Yu' && p[:last_name] == 'Darvish'
      end
    end
    subject { player.statistics.pitching }

    it 'parses out pitching stats' do
      expect(subject).to be_instance_of SportsDataApi::Mlb::MergedStats
      expect(subject[:bf]).to eq 24.0
      expect(subject[:bk]).to eq 0.0
      expect(subject[:era]).to eq 0.0
      expect(subject[:games_blown_save]).to eq 0
      expect(subject[:games_complete]).to eq 0
      expect(subject[:games_finish]).to eq 0
      expect(subject[:games_hold]).to eq 0
      expect(subject[:games_loss]).to eq 0
      expect(subject[:games_play]).to eq 1
      expect(subject[:games_qstart]).to eq 1
      expect(subject[:games_save]).to eq 0
      expect(subject[:games_shutout]).to eq 0
      expect(subject[:games_start]).to eq 1
      expect(subject[:games_svo]).to eq 0
      expect(subject[:games_win]).to eq 1
      expect(subject[:gofo]).to eq 1.0
      expect(subject[:ip_1]).to eq 21.0
      expect(subject[:ip_2]).to eq 7.0
      expect(subject[:k9]).to eq 11.574
      expect(subject[:kbb]).to eq 9.0
      expect(subject[:lob]).to eq 5.0
      expect(subject[:oba]).to eq 0.087
      expect(subject[:onbase_bb]).to eq 1
      expect(subject[:onbase_d]).to eq 0
      expect(subject[:onbase_fc]).to eq 0
      expect(subject[:onbase_h]).to eq 2
      expect(subject[:onbase_hbp]).to eq 0
      expect(subject[:onbase_hr]).to eq 0
      expect(subject[:onbase_ibb]).to eq 0
      expect(subject[:onbase_roe]).to eq 0
      expect(subject[:onbase_s]).to eq 2
      expect(subject[:onbase_t]).to eq 0
      expect(subject[:onbase_tb]).to eq 2
      expect(subject[:outcome_ball]).to eq 32
      expect(subject[:outcome_dirtball]).to eq 0
      expect(subject[:outcome_foul]).to eq 17
      expect(subject[:outcome_iball]).to eq 0
      expect(subject[:outcome_klook]).to eq 18
      expect(subject[:outcome_kswing]).to eq 18
      expect(subject[:outcome_ktotal]).to eq 36
      expect(subject[:outs_fidp]).to eq 0
      expect(subject[:outs_fo]).to eq 4
      expect(subject[:outs_gidp]).to eq 0
      expect(subject[:outs_go]).to eq 6
      expect(subject[:outs_klook]).to eq 1
      expect(subject[:outs_kswing]).to eq 8
      expect(subject[:outs_ktotal]).to eq 9
      expect(subject[:outs_lidp]).to eq 0
      expect(subject[:outs_lo]).to eq 2
      expect(subject[:outs_po]).to eq 0
      expect(subject[:outs_sacfly]).to eq 0
      expect(subject[:outs_sachit]).to eq 0
      expect(subject[:pitch_count]).to eq 99.0
      expect(subject[:runs_earned]).to eq 0
      expect(subject[:runs_total]).to eq 0
      expect(subject[:runs_unearned]).to eq 0
      expect(subject[:steal_caught]).to eq 0
      expect(subject[:steal_pickoff]).to eq 0
      expect(subject[:steal_stolen]).to eq 0
      expect(subject[:whip]).to eq 0.4286
      expect(subject[:wp]).to eq 0.0
    end
  end
end
