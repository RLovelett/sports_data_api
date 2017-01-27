require 'spec_helper'

describe SportsDataApi::Golf, vcr: {
    cassette_name: 'sports_data_api_golf',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:golf, 'invalid_key')
      SportsDataApi.set_access_level(:golf, 't')
    end
    describe '.season' do
      it { expect { subject.season(:pga, 2017) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.season' do
      it { expect { subject.season(:pga, 2017) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:season_url) { 'https://api.sportsdatallc.org/golf-t2/schedule/pga/2017/tournaments/schedule.json' }
    let(:tournaments_json) { RestClient.get("#{season_url}?api_key=#{api_key(:golf)}") }
    before do
      SportsDataApi.set_key(:golf, 'valid-key')
      SportsDataApi.set_access_level(:golf, 't')
    end
    describe '.season' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:golf) } }
        expect(RestClient).to receive(:get).with(season_url, params).and_return(tournaments_json)
        subject.season(:pga, 2017)
      end
    end
  end
end
