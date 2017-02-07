require 'spec_helper'

describe SportsDataApi::Golf, vcr: {
  cassette_name: 'sports_data_api_golf',
  record: :new_episodes,
  match_requests_on: [:method, :uri]
} do
  context 'with invalid tour' do
    describe '.season' do
      it do
        expect do
          subject.season(:lpga, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
    describe '.players' do
      it do
        expect do
          subject.players(:lpga, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
    describe '.summary' do
      it do
        expect do
          subject.summary(:lpga, nil, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
    describe '.tee_times' do
      it do
        expect do
          subject.tee_times(:lpga, nil, nil, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
    describe '.scorecards' do
      it do
        expect do
          subject.scorecards(:lpga, nil, nil, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
    describe '.leaderboard' do
      it do
        expect do
          subject.leaderboard(:lpga, nil, nil)
        end.to raise_error(SportsDataApi::Golf::Exception, 'lpga is not a valid tour')
      end
    end
  end
  context 'invalid API key' do
    before do
      SportsDataApi.set_key(:golf, 'invalid_key')
      SportsDataApi.set_access_level(:golf, 't')
    end
    describe '.season' do
      it { expect { subject.season(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.players' do
      it { expect { subject.players(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.summary' do
      it { expect { subject.summary(:pga, 2016, 'id') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.tee_times' do
      it { expect { subject.tee_times(:pga, 2016, 'id', 1) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.scorecards' do
      it { expect { subject.scorecards(:pga, 2016, 'id', 1) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.leaderboard' do
      it { expect { subject.leaderboard(:pga, 2016, 'id') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.season' do
      it { expect { subject.season(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.players' do
      it { expect { subject.players(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.summary' do
      it { expect { subject.summary(:pga, 2016, '123') }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.tee_times' do
      it { expect { subject.tee_times(:pga, 2016, '123', 1) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.scorecards' do
      it { expect { subject.scorecards(:pga, 2016, '123', 1) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.leaderboard' do
      it { expect { subject.leaderboard(:pga, 2016, '123') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'valid API key' do
    before do
      SportsDataApi.set_key(:golf, 'valid-key')
      SportsDataApi.set_access_level(:golf, 't')
    end
    describe '.season' do
      it 'creates a valid Sports Data LLC url' do
        season_url = 'https://api.sportsdatallc.org/golf-t2/schedule/pga/2016/tournaments/schedule.json'
        tournaments_json = RestClient.get("#{season_url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { tournaments_json }

        subject.season(:pga, 2016)

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(season_url, params)
      end
    end
    describe '.players' do
      it 'creates a valid Sports Data LLC url' do
        players_url = 'https://api.sportsdatallc.org/golf-t2/profiles/pga/2016/players/profiles.json'
        players_json = RestClient.get("#{players_url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { players_json }

        subject.players(:pga, 2016)

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(players_url, params)
      end
    end
    describe '.summary' do
      it 'creates a valid Sports Data LLC url' do
        summary_url = 'https://api.sportsdatallc.org/golf-t2/summary/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/summary.json'
        summary_json = RestClient.get("#{summary_url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { summary_json }

        response = subject.summary(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea')

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(summary_url, params)
        expect(response).to be_an_instance_of(SportsDataApi::Golf::Summary)
      end
    end
    describe '.tee_times' do
      it 'creates a valid Sports Data LLC url' do
        tee_times_url = 'https://api.sportsdatallc.org/golf-t2/teetimes/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/rounds/2/teetimes.json'
        tee_times_json = RestClient.get("#{tee_times_url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { tee_times_json }

        response = subject.tee_times(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea', 2)

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(tee_times_url, params)
        expect(response.length).to eq 1
        expect(response.first).to be_an_instance_of(SportsDataApi::Golf::Course)
      end
    end
    describe '.scorecards' do
      it 'creates a valid Sports Data LLC url' do
        url = 'https://api.sportsdatallc.org/golf-t2/scorecards/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/rounds/2/scores.json'
        json = RestClient.get("#{url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { json }

        response = subject.scorecards(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea', 2)

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(url, params)
        players = response[:players]
        expect(players.length).to eq 97
        expect(players.first).to be_an_instance_of(SportsDataApi::Golf::Player)
        expect(response[:round]).to eq 2
        expect(response[:status]).to eq 'closed'
        expect(response[:tournament_id]).to eq 'b95ab96b-9a0b-4309-880a-ad063cb163ea'
        expect(response[:year]).to eq 2016
        expect(response[:tour]).to eq :pga
      end
    end
    describe '.leaderboard' do
      it 'creates a valid Sports Data LLC url' do
        url = 'https://api.sportsdatallc.org/golf-t2/leaderboard/pga/2016/tournaments/b95ab96b-9a0b-4309-880a-ad063cb163ea/leaderboard.json'
        json = RestClient.get("#{url}?api_key=#{api_key(:golf)}")
        allow(RestClient).to receive(:get) { json }

        response = subject.leaderboard(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea')

        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to have_received(:get).with(url, params)
        expect(response.length).to eq 97
        expect(response.first).to be_an_instance_of(SportsDataApi::Golf::Player)
      end
    end
  end
end
