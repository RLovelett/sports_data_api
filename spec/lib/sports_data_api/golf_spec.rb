require 'spec_helper'

describe SportsDataApi::Golf, vcr: {
  cassette_name: 'sports_data_api_golf',
  record: :new_episodes,
  match_requests_on: [:method, :uri]
} do
  context 'invalid API key' do
    before do
      SportsDataApi.set_key(:golf, 'invalid_key')
      SportsDataApi.set_access_level(:golf, 't')
    end
    describe '.season' do
      it { expect { subject.season(:pga, 2016) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.players' do
      it { expect { subject.players(:pga, 2016) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.summary' do
      it { expect { subject.summary(:pga, 2016, 'id') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.tee_times' do
      it { expect { subject.tee_times(:pga, 2016, 'id', 1) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.scorecards' do
      it { expect { subject.scorecards(:pga, 2016, 'id', 1) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.leaderboard' do
      it { expect { subject.leaderboard(:pga, 2016, 'id') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'no response from the api' do
    before { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.season' do
      it { expect { subject.season(:pga, 2016) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.players' do
      it { expect { subject.players(:pga, 2016) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.summary' do
      it { expect { subject.summary(:pga, 2016, '123') }.to raise_error(SportsDataApi::Error) }
    end
    describe '.tee_times' do
      it { expect { subject.tee_times(:pga, 2016, '123', 1) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.scorecards' do
      it { expect { subject.scorecards(:pga, 2016, '123', 1) }.to raise_error(SportsDataApi::Error) }
    end
    describe '.leaderboard' do
      it { expect { subject.leaderboard(:pga, 2016, '123') }.to raise_error(SportsDataApi::Error) }
    end
  end

  context 'valid API key' do
    let(:params) { { params: { api_key: api_key(:golf) } } }
    let(:json) { RestClient.get(url, params) }
    before do
      SportsDataApi.set_key(:golf, api_key(:golf))
      SportsDataApi.set_access_level(:golf, 't')
      allow(RestClient).to receive(:get).and_return(json)
    end
    describe '.season' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/schedule/pga/2016/tournaments/schedule.json' }

      it 'creates a valid Sports Data LLC url' do
        expect(subject.season(:pga, 2016)).to be_a SportsDataApi::Golf::Season
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.players' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/profiles/pga/2016/players/profiles.json' }

      it 'creates a valid Sports Data LLC url' do
        response = subject.players(:pga, 2016)
        expect(response).to be_a Array
        expect(response.first).to be_a SportsDataApi::Golf::Player
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.summary' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/summary/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/summary.json' }

      it 'creates a valid Sports Data LLC url' do
        response = subject.summary(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea')
        expect(response).to be_an_instance_of(SportsDataApi::Golf::Summary)
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.tee_times' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/teetimes/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/rounds/2/teetimes.json' }

      it 'creates a valid Sports Data LLC url' do
        response = subject.tee_times(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea', 2)
        expect(response.length).to eq 1
        expect(response.first).to be_an_instance_of(SportsDataApi::Golf::Course)
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
    describe '.scorecards' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/scorecards/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/rounds/2/scores.json' }

      it 'creates a valid Sports Data LLC url' do
        response = subject.scorecards(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea', 2)

        players = response[:players]
        expect(players.length).to eq 97
        expect(players.first).to be_an_instance_of(SportsDataApi::Golf::Player)
        expect(response[:round]).to eq 2
        expect(response[:status]).to eq 'closed'
        expect(response[:tournament_id]).to eq 'b95ab96b-9a0b-4309-880a-ad063cb163ea'
        expect(response[:year]).to eq 2016
        expect(response[:tour]).to eq :pga
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end

    describe '.leaderboard' do
      let(:url) { 'https://api.sportsdatallc.org/golf-t2/leaderboard/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/leaderboard.json' }

      it 'creates a valid Sports Data LLC url' do
        response = subject.leaderboard(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea')

        expect(response.length).to eq 97
        expect(response.first).to be_an_instance_of(SportsDataApi::Golf::Player)
        expect(RestClient).to have_received(:get).with(url, params)
      end
    end
  end
end
