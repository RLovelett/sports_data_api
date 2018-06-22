require 'spec_helper'

describe SportsDataApi::Nfl, vcr: {
    cassette_name: 'sports_data_api_nfl',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:nfl, 'invalid_key')
      SportsDataApi.set_access_level(:nfl, 'ot')
    end

    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.boxscore' do
      it { expect { subject.boxscore('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game_roster' do
      it { expect { subject.game_roster('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.team_roster' do
      it { expect { subject.team_roster('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game_statistics' do
      it { expect { subject.game_statistics('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }

    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.boxscore' do
      it { expect { subject.boxscore('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game_roster' do
      it { expect { subject.game_roster('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.team_roster' do
      it { expect { subject.team_roster('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.teams' do
      it { expect { subject.teams }.to raise_error(SportsDataApi::Error) }
    end
    describe '.game_statistics' do
      it { expect { subject.game_statistics('55d0b262-98ff-49fa-95c8-5ab8ec8cbd34') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'create valid URLs' do
    let(:full_url) { "#{url}?api_key=#{api_key(:nfl)}" }
    let(:json) { RestClient.get(full_url) }
    let(:params) { { params: { api_key: api_key(:nfl) } } }

    before(:each) do
      SportsDataApi.set_key(:nfl, api_key(:nfl))
      SportsDataApi.set_access_level(:nfl, 'ot')
      allow(RestClient).to receive(:get).and_return(json)
    end

    describe '.schedule' do
      let(:url) { 'https://api.sportradar.us/nfl-ot2/games/2012/REG/schedule.json' }

      it 'makes a valid request and returns a Season' do
        response = subject.schedule(2012, :REG)
        expect(response).to be_a SportsDataApi::Nfl::Season
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.boxscore' do
      let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
      let(:url) { "https://api.sportradar.us/nfl-ot2/games/#{game_id}/boxscore.json" }

      it 'makes a valid request and returns a Game' do
        response = subject.boxscore(game_id)
        expect(response).to be_a SportsDataApi::Nfl::Game
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.game_roster' do
      let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
      let(:url) { "https://api.sportradar.us/nfl-ot2/games/#{game_id}/roster.json" }

      it 'makes a valid request and returns a Game' do
        response = subject.game_roster(game_id)
        expect(response).to be_a SportsDataApi::Nfl::Game
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.team_roster' do
      let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
      let(:url) { "https://api.sportradar.us/nfl-ot2/teams/#{team_id}/full_roster.json" }

      it 'makes a valid request and returns a Team' do
        response = subject.team_roster(team_id)
        expect(response).to be_a SportsDataApi::Nfl::Team
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.teams' do
      let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
      let(:url) { "https://api.sportradar.us/nfl-ot2/league/hierarchy.json" }

      it 'makes a valid request and returns a Teams' do
        response = subject.teams
        expect(response).to be_a SportsDataApi::Nfl::Teams
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.game_statistics' do
      let(:game_id) { '55d0b262-98ff-49fa-95c8-5ab8ec8cbd34' }
      let(:url) { "https://api.sportradar.us/nfl-ot2/games/#{game_id}/statistics.json" }

      it 'makes a valid request and returns a Game' do
        response = subject.game_statistics(game_id)
        expect(response).to be_a SportsDataApi::Nfl::Game
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
  end
end
