require 'spec_helper'

describe SportsDataApi::Mlb do
  context 'invalid API key', vcr: {
    cassette_name: 'sports_data_api_mlb_invalid',
    record: :none,
    match_requests_on: [:host, :path]
  } do
    before do
      SportsDataApi.set_key(:mlb, 'invalid_key')
      SportsDataApi.set_access_level(:mlb, 't')
    end
    describe '.leagues' do
      it { expect { subject.leagues }.to raise_error(SportsDataApi::Error) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end
    describe '.season_schedule' do
      it { expect { subject.season_schedule(2017, :REG) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.daily_schedule' do
      it { expect { subject.daily_schedule(2016, 9, 24) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.daily_summary' do
      it { expect { subject.daily_summary(2016, 9, 24) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game' do
      it { expect { subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.team' do
      it { expect { subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'no response from the api' do
    before { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }
    describe '.leagues' do
      it { expect { subject.leagues }.to raise_error(SportsDataApi::Error) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end
    describe '.season_schedule' do
      it { expect { subject.season_schedule(2017, :REG) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.daily_schedule' do
      it { expect { subject.daily_schedule(2016, 9,24) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.daily_summary' do
      it { expect { subject.daily_summary(2016, 9,24) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game' do
      it { expect { subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.team' do
      it { expect { subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'valid API key', vcr: {
    cassette_name: 'sports_data_api_mlb',
    record: :none,
    match_requests_on: [:host, :path]
  } do
    let(:params) { { params: { api_key: api_key(:mlb) } } }
    let(:json) { RestClient.get(url, params) }

    before do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      allow(RestClient).to receive(:get).and_return(json)
    end
    describe '.leagues' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/league/hierarchy.json' }

      it 'creates a valid url' do
        subject.leagues
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.teams' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/league/hierarchy.json' }
      it 'creates a valid url' do
        teams = subject.teams
        expect(teams.count).to eq 30
        expect(teams.first).to be_instance_of SportsDataApi::Mlb::Team
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.season_schedule' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/games/2017/REG/schedule.json' }

      it 'creates a valid url' do
        subject.season_schedule(2017, :REG)
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.daily_schedule' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/games/2016/9/24/schedule.json' }

      it 'creates a valid url' do
        subject.daily_schedule(2016, 9, 24)
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.daily_summary' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/games/2016/9/24/summary.json' }

      it 'creates a valid url' do
        games = subject.daily_summary(2016, 9, 24)

        game = games.first
        expect(games.count).to eq 15
        expect(game).to be_instance_of(SportsDataApi::Mlb::Game)
        expect(game[:home]).to be_instance_of(SportsDataApi::Mlb::Team)
        expect(game.home[:id]).to eq '27a59d3b-ff7c-48ea-b016-4798f560f5e1'
        expect(game[:away]).to be_instance_of(SportsDataApi::Mlb::Team)
        expect(game.away[:id]).to eq 'd99f919b-1534-4516-8e8a-9cd106c6d8cd'
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.game' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/games/4f46825d-8172-47bc-9f06-2a162c330ffb/summary.json' }

      it 'creates a valid url' do
        subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb')
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.team' do
      let(:url) { 'https://api.sportradar.us/mlb-t6/teams/575c19b7-4052-41c2-9f0a-1c5813d02f99/profile.json' }

      it 'creates a valid url' do
        subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99')
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
  end
end
