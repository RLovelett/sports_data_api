require 'spec_helper'

describe SportsDataApi::Ncaamb, vcr: {
    cassette_name: 'sports_data_api_ncaamb',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:ncaamb, 'invalid_key')
      SportsDataApi.set_access_level(:ncaamb, 't')
    end
    describe '.schedule' do
      it { expect { subject.schedule(2014, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2014, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:schedule_url) { 'https://api.sportsdatallc.org/ncaamb-t3/games/2014/REG/schedule.xml' }
    before(:each) do
      SportsDataApi.set_key(:ncaamb, 'invalid_key')
      SportsDataApi.set_access_level(:ncaamb, 't')
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key(:ncaamb)}")
    end
    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:ncaamb) } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2014, :REG)
      end
    end
  end
end
