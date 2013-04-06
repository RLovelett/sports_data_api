require 'spec_helper'

describe SportsDataApi::Nfl, vcr: {
    cassette_name: 'sports_data_api_nfl',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'invalid API key' do
    before(:each) do
      SportsDataApi.key = 'invalid_key'
      SportsDataApi.access_level = 't'
    end
    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.boxscore' do
      it { expect { subject.boxscore(2012, :REG, 9, 'IND', 'MIA') }.to raise_error(SportsDataApi::Exception) }
    end
  end
  context 'no response from the api' do
    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.boxscore' do
      it { expect { subject.boxscore(2012, :REG, 9, 'IND', 'MIA') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  describe '.schedule' do
    it 'creates a valid Sports Data LLC url' do
      params = { params: { api_key: SportsDataApi.key } }
      RestClient.should_receive(:get).with('http://api.sportsdatallc.org/nfl-t1/2012/REG/schedule.xml', params).and_return(schedule_xml)
      subject.schedule(2012, :REG)
    end
  end

  describe '.boxscore' do
    it 'creates a valid Sports Data LLC url' do
      params = { params: { api_key: SportsDataApi.key } }
      RestClient.should_receive(:get).with('http://api.sportsdatallc.org/nfl-t1/2012/REG/9/MIA/IND/boxscore.xml', params).and_return(schedule_xml)
      subject.boxscore(2012, :REG, 9, 'IND', 'MIA')
    end
  end
end
