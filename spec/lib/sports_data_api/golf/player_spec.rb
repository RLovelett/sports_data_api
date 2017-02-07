require 'spec_helper'

describe SportsDataApi::Golf::Player, vcr: {
  cassette_name: 'sports_data_api_golf',
  record: :none,
  match_requests_on: [:path]
} do
  context 'results from players fetch' do
    let(:players) do
      SportsDataApi.set_access_level(:golf, 't')
      SportsDataApi.set_key(:golf, api_key(:golf))
      SportsDataApi::Golf.players(:pga, 2016)
    end

    it 'populates each field' do
      subject = players.first
      expect(subject).to be_instance_of(SportsDataApi::Golf::Player)
      expect(subject[:id]).to eq '15a0ce0b-1c58-4aa2-8510-fe39a3684585'
      expect(subject[:first_name]).to eq 'Bill'
      expect(subject[:last_name]).to eq 'Glasson'
      expect(subject[:height]).to eq 71
      expect(subject[:weight]).to eq 175
      expect(subject[:birthday]).to eq '1960-04-29'
      expect(subject[:country]).to eq 'UNITED STATES'
      expect(subject[:residence]).to eq 'Stillwater, OK, USA'
      expect(subject[:college]).to eq 'Oral Roberts'
      expect(subject[:turned_pro]).to eq 1983
      expect(subject[:member]).to eq false
      expect(subject[:updated]).to eq '2016-06-08T14:53:32+00:00'
      expect(subject.course).to be_nil
      expect(subject.scores).to be_empty
      expect(subject.rounds).to be_empty
    end
  end

  context 'results from scorecards fetch' do
    let(:scorecard) do
      SportsDataApi.set_access_level(:golf, 't')
      SportsDataApi.set_key(:golf, api_key(:golf))
      SportsDataApi::Golf.scorecards(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea', 2)
    end
    it 'populates each field and course' do
      result = scorecard
      expect(result[:status]).to eq 'closed'
      expect(result[:round]).to eq 2
      expect(result[:tournament_id]).to eq 'b95ab96b-9a0b-4309-880a-ad063cb163ea'
      expect(result[:year]).to eq 2016
      expect(result[:tour]).to eq :pga
      subject = result[:players].first
      expect(subject).to be_instance_of(SportsDataApi::Golf::Player)
      expect(subject[:id]).to eq '94c4646a-c6f7-4bc8-9543-ac7e93814cd7'
      expect(subject[:first_name]).to eq 'Ryan'
      expect(subject[:last_name]).to eq 'Moore'
      expect(subject[:score]).to eq(-6)
      expect(subject[:thru]).to eq 18
      expect(subject[:strokes]).to eq 66
      expect(subject[:eagles]).to eq 0
      expect(subject[:birdies]).to eq 7
      expect(subject[:pars]).to eq 10
      expect(subject[:bogeys]).to eq 1
      expect(subject[:double_bogeys]).to eq 0
      expect(subject[:holes_in_one]).to eq 0
      expect(subject[:other_scores]).to eq 0
      expect(subject.course).to be_an_instance_of(SportsDataApi::Golf::Course)
      expect(subject.scores.length).to eq 18
      expect(subject.scores.first).to be_instance_of(SportsDataApi::Golf::Score)
      expect(subject.rounds).to be_empty
    end
  end

  context 'results from leaderboard fetch' do
    let(:players) do
      SportsDataApi.set_access_level(:golf, 't')
      SportsDataApi.set_key(:golf, api_key(:golf))
      SportsDataApi::Golf.leaderboard(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea')
    end
    it 'populates each field and course' do
      subject = players.first
      expect(subject).to be_instance_of(SportsDataApi::Golf::Player)
      expect(subject[:id]).to eq '3e4963cb-6e80-4393-85cf-2aecec453c4a'
      expect(subject[:first_name]).to eq 'Jordan'
      expect(subject[:last_name]).to eq 'Spieth'
      expect(subject[:country]).to eq 'UNITED STATES'
      expect(subject[:tied]).to eq false
      expect(subject[:position]).to eq 1
      expect(subject[:money]).to eq 1_800_000
      expect(subject[:points]).to eq 600
      expect(subject[:score]).to eq(-18)
      expect(subject[:strokes]).to eq(270)
      expect(subject.course).to be_nil
      expect(subject.scores).to be_empty
      expect(subject.rounds.length).to eq 4
      expect(subject.rounds.first).to be_an_instance_of(SportsDataApi::Golf::Round)
    end
  end
end
