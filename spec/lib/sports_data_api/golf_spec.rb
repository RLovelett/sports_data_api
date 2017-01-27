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
  end

  context 'no response from the api' do
    before { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.season' do
      it { expect { subject.season(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.players' do
      it { expect { subject.players(:pga, 2016) }.to raise_error(SportsDataApi::Exception) }
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
  end
end
