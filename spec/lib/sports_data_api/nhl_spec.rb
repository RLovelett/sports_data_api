require 'spec_helper'

describe SportsDataApi::Nhl, vcr: {
    cassette_name: 'sports_data_api_nhl',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:nhl, 'invalid_key')
      SportsDataApi.set_access_level(:nhl, 't')
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
    let(:schedule_url) { 'https://api.sportsdatallc.org/nhl-t3/games/2013/REG/schedule.xml' }
    before(:each) do
      SportsDataApi.set_key(:nhl, 'invalid_key')
      SportsDataApi.set_access_level(:nhl, 't')
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key(:nhl)}")
    end
    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key(:nhl) } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2013, :REG)
      end
    end
  end
end
