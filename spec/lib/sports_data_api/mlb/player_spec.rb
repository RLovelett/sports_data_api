require 'spec_helper'

describe SportsDataApi::Mlb::Player, vcr: {
  cassette_name: 'sports_data_api_mlb_player',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  context 'when from a game summary' do
    let(:game) {
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.game('4f46825d-8172-47bc-9f06-2a162c330ffb')
    }
    let(:team) { game.away }

    context 'when a pitcher' do
      subject do
        team.players.find do |p|
          p[:first_name] == 'Yu' && p[:last_name] == 'Darvish'
        end
      end
      it 'parses details' do
        expect(subject).to be_instance_of(SportsDataApi::Mlb::Player)
        expect(subject[:id]).to eq 'cc672f14-6c84-4dde-8beb-90664d467843'
      end

      it '#statistics parses statistics' do
        expect(subject.statistics).to be_instance_of(SportsDataApi::Mlb::Statistics)
      end
    end

    context 'when a fielder' do
      subject do
        team.players.find do |p|
          p[:first_name] == 'Elvis' && p[:last_name] == 'Andrus'
        end
      end

      it 'parses details' do
        expect(subject).to be_instance_of(SportsDataApi::Mlb::Player)
        expect(subject[:id]).to eq '85d6d865-97c4-427b-8f4f-eb6dad286e57'
      end

      it '#statistics parses statistics' do
        expect(subject.statistics).to be_instance_of(SportsDataApi::Mlb::Statistics)
      end
    end
  end

  context 'when from a team profile' do
    let(:team) do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.team('575c19b7-4052-41c2-9f0a-1c5813d02f99')
    end
    subject { team.players.first }

    its(:statistics) { should be_nil }

    it 'parses details' do
      expect(subject).to be_instance_of(SportsDataApi::Mlb::Player)
      expect(subject[:id]).to eq '5d9db92f-7b74-4235-a2e6-673620b3f7c7'
    end
  end
end
