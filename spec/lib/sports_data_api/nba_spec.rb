require 'spec_helper'

describe SportsDataApi::Nba, vcr: {
  cassette_name: 'sports_data_api_nba',
  record: :new_episodes,
  match_requests_on: [:method, :uri]
} do

  context 'invalid API key' do
    before do
      SportsDataApi.set_key(:nba, 'invalid_key')
      SportsDataApi.set_access_level(:nba, 'trial')
    end

    describe '.schedule' do
      it { expect { subject.schedule(2017, :REG) }.to raise_error(SportsDataApi::Error) }
    end

    describe '.team_roster' do
      it { expect { subject.team_roster('team_uuid') }.to raise_error(SportsDataApi::Error) }
    end

    describe '.game_summary' do
      it { expect { subject.game_summary('game_uuid') }.to raise_error(SportsDataApi::Error) }
    end

    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end

    describe '.daily' do
      it { expect { subject.daily(2017, 1, 1) }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'no response from the api' do
    before do
      SportsDataApi.set_key(:nba, 'invalid_key')
      SportsDataApi.set_access_level(:nba, 'trial')
    end

    before { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }

    describe '.schedule' do
      it { expect { subject.schedule(2017, :REG) }.to raise_error(SportsDataApi::Error) }
    end

    describe '.team_roster' do
      it { expect { subject.team_roster('team_uuid') }.to raise_error(SportsDataApi::Error) }
    end

    describe '.game_summary' do
      it { expect { subject.game_summary('game_uuid') }.to raise_error(SportsDataApi::Error) }
    end

    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end

    describe '.daily' do
      it { expect { subject.daily(2017, 1, 1) }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'create valid URLs' do
    before do
      SportsDataApi.set_key(:nba, 'valid_key')
      SportsDataApi.set_access_level(:nba, 'trial')
    end

    describe '.schedule' do
      let(:url) { 'https://api.sportradar.us/nba/trial/v4/en/games/2017/REG/schedule.json' }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nba)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.schedule(2017, :REG)).to be_a SportsDataApi::Nba::Season
      end
    end

    describe '.team_roster' do
      let(:team_id) { '583ec825-fb46-11e1-82cb-f4ce4684ea4c' }
      let(:url) { "https://api.sportradar.us/nba/trial/v4/en/teams/#{team_id}/profile.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nba)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.team_roster(team_id)).to be_a SportsDataApi::Nba::Team
      end
    end

    describe '.game_summary' do
      let(:game_id) { '114844aa-3c31-4ac7-9afa-0a4f2ae65e0c' }
      let(:url) { "https://api.sportradar.us/nba/trial/v4/en/games/#{game_id}/summary.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nba)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.game_summary(game_id)).to be_a SportsDataApi::Nba::Game
      end
    end

    describe '.teams' do
      let(:url) { "https://api.sportradar.us/nba/trial/v4/en/league/hierarchy.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nba)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.teams).to be_a SportsDataApi::Nba::Teams
      end
    end

    describe '.daily' do
      let(:url) { "https://api.sportradar.us/nba/trial/v4/en/games/2018/1/1/schedule.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nba)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.daily(2018, 1, 1)).to be_a SportsDataApi::Nba::Games
      end
    end
  end
end
