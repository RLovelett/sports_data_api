require 'spec_helper'

describe SportsDataApi::Mlb::Team, vcr: {
    cassette_name: 'sports_data_api_mlb_team',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'when instance from team profile fetch' do
    subject do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.team('575c19b7-4052-41c2-9f0a-1c5813d02f99')
    end

    it { should be_an_instance_of(SportsDataApi::Mlb::Team) }
    its(:roster) { should be_empty }
    its(:starting_pitcher) { should be_nil }
    its(:probable_pitcher) { should be_nil }

    it 'sets the id' do
      expect(subject[:id]).to eq '575c19b7-4052-41c2-9f0a-1c5813d02f99'
    end

    describe '#players' do
      it 'parses all players into Player models' do
        expect(subject[:players].count).to eq 40
        player = subject.players.first
        expect(player).to be_instance_of(SportsDataApi::Mlb::Player)
        expect(player[:id]).to eq '5d9db92f-7b74-4235-a2e6-673620b3f7c7'
      end
    end
  end
  context 'when instance from games' do
    subject do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.game('4f46825d-8172-47bc-9f06-2a162c330ffb').home
    end

    it { should be_an_instance_of(SportsDataApi::Mlb::Team) }

    it 'sets the id' do
      expect(subject[:id]).to eq '27a59d3b-ff7c-48ea-b016-4798f560f5e1'
    end

    describe '#players' do
      it 'parses the players' do
        expect(subject[:players].count).to eq 17
        player = subject.players.first
        expect(player).to be_instance_of(SportsDataApi::Mlb::Player)
        expect(player[:id]).to eq '169b7765-2519-4f2f-a67f-2e010c0d361e'
      end
    end

    describe '#roster' do
      it 'parses all roster into Player models' do
        expect(subject[:roster].count).to eq 33
        player = subject.roster.first
        expect(player).to be_instance_of(SportsDataApi::Mlb::Player)
        expect(player[:id]).to eq '01827908-3b4a-4024-84c0-fac5a1a6bf6a'
      end
    end

    describe '#probable_pitcher' do
      it 'parses pitcher' do
        pitcher = subject.probable_pitcher
        expect(pitcher).to be_an_instance_of(SportsDataApi::Mlb::Player)
        expect(pitcher[:id]).to eq '35cbd12c-9d2d-4eae-a546-be0ff0feef5c'
      end
    end

    describe '#starting_pitcher' do
      it 'parses pitcher' do
        pitcher = subject.starting_pitcher
        expect(pitcher).to be_an_instance_of(SportsDataApi::Mlb::Player)
        expect(pitcher[:id]).to eq '35cbd12c-9d2d-4eae-a546-be0ff0feef5c'
      end
    end
  end
end
