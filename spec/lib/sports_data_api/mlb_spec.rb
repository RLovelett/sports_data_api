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
      it { expect { subject.leagues }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.season_schedule' do
      it { expect { subject.season_schedule(2017, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.daily_schedule' do
      it { expect { subject.daily_schedule(2016, 9, 24) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.daily_summary' do
      it { expect { subject.daily_summary(2016, 9, 24) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.game' do
      it { expect { subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.team' do
      it { expect { subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }
    describe '.leagues' do
      it { expect { subject.leagues }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.season_schedule' do
      it { expect { subject.season_schedule(2017, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.daily_schedule' do
      it { expect { subject.daily_schedule(2016, 9,24) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.daily_summary' do
      it { expect { subject.daily_summary(2016, 9,24) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.game' do
      it { expect { subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.team' do
      it { expect { subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'valid API key', vcr: {
    cassette_name: 'sports_data_api_mlb',
    record: :none,
    match_requests_on: [:host, :path]
  } do
    before do
      SportsDataApi.set_key(:mlb, 'valid-key')
      SportsDataApi.set_access_level(:mlb, 't')
    end
    describe '.leagues' do
      it 'creates a valid url' do
        season_url = 'https://api.sportradar.us/mlb-t6/league/hierarchy.json'
        schedule_json = RestClient.get("#{season_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { schedule_json }

        subject.leagues

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(season_url, params)
      end
    end
    describe '.teams' do
      it 'creates a valid url' do
        season_url = 'https://api.sportradar.us/mlb-t6/league/hierarchy.json'
        schedule_json = RestClient.get("#{season_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { schedule_json }

        teams = subject.teams

        expect(teams.count).to eq 30
        expect(teams.first).to be_instance_of SportsDataApi::Mlb::Team
        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(season_url, params)
      end
    end
    describe '.season_schedule' do
      it 'creates a valid url' do
        season_url = 'https://api.sportradar.us/mlb-t6/games/2017/REG/schedule.json'
        schedule_json = RestClient.get("#{season_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { schedule_json }

        subject.season_schedule(2017, :REG)

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(season_url, params)
      end
    end
    describe '.daily_schedule' do
      it 'creates a valid url' do
        daily_url = 'https://api.sportradar.us/mlb-t6/games/2016/9/24/schedule.json'
        schedule_json = RestClient.get("#{daily_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { schedule_json }

        subject.daily_schedule(2016, 9, 24)

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(daily_url, params)
      end
    end
    describe '.daily_summary' do
      it 'creates a valid url' do
        daily_url = 'https://api.sportradar.us/mlb-t6/games/2016/9/24/summary.json'
        summary_json = RestClient.get("#{daily_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { summary_json }

        subject.daily_summary(2016, 9, 24)

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(daily_url, params)
      end
    end
    describe '.game' do
      it 'creates a valid url' do
        game_url = 'https://api.sportradar.us/mlb-t6/games/4f46825d-8172-47bc-9f06-2a162c330ffb/summary.json'
        game_json = RestClient.get("#{game_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { game_json }

        subject.game('4f46825d-8172-47bc-9f06-2a162c330ffb')

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(game_url, params)
      end
    end
    describe '.team' do
      it 'creates a valid url' do
        team_url = 'https://api.sportradar.us/mlb-t6/teams/575c19b7-4052-41c2-9f0a-1c5813d02f99/profile.json'
        team_json = RestClient.get("#{team_url}?api_key=#{api_key(:mlb)}")
        allow(RestClient).to receive(:get) { team_json }

        subject.team('575c19b7-4052-41c2-9f0a-1c5813d02f99')

        params = { params: { api_key: SportsDataApi.key(:mlb) } }
        expect(RestClient).to have_received(:get).with(team_url, params)
      end
    end
  end
end
