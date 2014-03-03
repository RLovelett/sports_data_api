require 'spec_helper'

describe SportsDataApi::Nba, vcr: {
    cassette_name: 'sports_data_api_nba',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:nba, 'invalid_key')
      SportsDataApi.set_access_level(:nba, 't')
    end
    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:schedule_url) { 'http://api.sportsdatallc.org/nba-t3/games/2013/REG/schedule.xml' }
    before(:each) do
      SportsDataApi.set_key(:nba, 'invalid_key')
      SportsDataApi.set_access_level(:nba, 't')
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key(:nba)}")
    end
    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nba) } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2013, :REG)
      end
    end
  end
end
