require 'spec_helper'

describe SportsDataApi::Nhl, vcr: {
    cassette_name: 'sports_data_api_nhl',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before do
      SportsDataApi.set_key(:nhl, 'invalid_key')
      SportsDataApi.set_access_level(:nhl, 'trial')
    end

    describe '.schedule' do
      it { expect { subject.schedule(2017, :REG) }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.team_roster' do
      it { expect { subject.team_roster('team_uuid') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.game_summary' do
      it { expect { subject.game_summary('game_uuid') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.daily' do
      it { expect { subject.daily(2017, 1, 1) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before do
      SportsDataApi.set_key(:nhl, 'invalid_key')
      SportsDataApi.set_access_level(:nhl, 'trial')
    end

    before { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }

    describe '.schedule' do
      it { expect { subject.schedule(2017, :REG) }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.team_roster' do
      it { expect { subject.team_roster('team_uuid') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.game_summary' do
      it { expect { subject.game_summary('game_uuid') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.daily' do
      it { expect { subject.daily(2017, 1, 1) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    before do
      SportsDataApi.set_key(:nhl, 'valid_key')
      SportsDataApi.set_access_level(:nhl, 'trial')
    end

    describe '.schedule' do
      let(:url) { 'https://api.sportradar.us/nhl/trial/v5/en/games/2017/REG/schedule.json' }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nhl)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.schedule(2017, :REG)).to be_a SportsDataApi::Nhl::Season
      end
    end

    describe '.team_roster' do
      let(:team_id) { '4416091c-0f24-11e2-8525-18a905767e44' }
      let(:url) { "https://api.sportradar.us/nhl/trial/v5/en/teams/#{team_id}/profile.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nhl)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.team_roster(team_id)).to be_a SportsDataApi::Nhl::Team
      end
    end

    describe '.game_summary' do
      let(:game_id) { 'af285aa3-3d80-4051-9449-5b58e5985a4e' }
      let(:url) { "https://api.sportradar.us/nhl/trial/v5/en/games/#{game_id}/summary.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nhl)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.game_summary(game_id)).to be_a SportsDataApi::Nhl::Game
      end
    end

    describe '.teams' do
      let(:url) { "https://api.sportradar.us/nhl/trial/v5/en/league/hierarchy.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nhl)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.teams).to be_a SportsDataApi::Nhl::Teams
      end
    end

    describe '.daily' do
      let(:url) { "https://api.sportradar.us/nhl/trial/v5/en/games/2018/1/1/schedule.json" }
      let!(:json) { RestClient.get("#{url}?api_key=#{api_key(:nhl)}") }
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(url, params).and_return(json)
        expect(subject.daily(2018, 1, 1)).to be_a SportsDataApi::Nhl::Games
      end
    end
  end
end
