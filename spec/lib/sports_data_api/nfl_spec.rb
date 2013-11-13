require 'spec_helper'

describe SportsDataApi::Nfl, vcr: {
    cassette_name: 'sports_data_api_nfl',
    record: :new_episodes,
    match_requests_on: [:uri]
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
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end
    describe '.boxscore' do
      it { expect { subject.boxscore(2012, :REG, 9, 'IND', 'MIA') }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'create valid URLs' do
    let(:schedule_url) { 'http://api.sportsdatallc.org/nfl-t1/2012/REG/schedule.xml' }
    let(:boxscore_url) { 'http://api.sportsdatallc.org/nfl-t1/2012/REG/9/MIA/IND/boxscore.xml' }
    before(:each) do
      SportsDataApi.key = 'invalid_key'
      SportsDataApi.access_level = 't'
      @schedule_xml = RestClient.get("#{schedule_url}?api_key=#{api_key}")
      @boxscore_xml = RestClient.get("#{boxscore_url}?api_key=#{api_key}")
    end
    describe '.schedule' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key } }
        RestClient.should_receive(:get).with(schedule_url, params).and_return(@schedule_xml)
        subject.schedule(2012, :REG)
      end
    end

    describe '.boxscore' do
      it 'creates a valid Sports Data LLC url' do
        params = { params: { api_key: SportsDataApi.key } }
        RestClient.should_receive(:get).with(boxscore_url, params).and_return(@boxscore_xml)
        subject.boxscore(2012, :REG, 9, 'IND', 'MIA')
      end
    end
  end

  context '#get_teams' do
    before do
      SportsDataApi.key = api_key
      SportsDataApi.access_level = 't'
    end
    it "returns an array" do
      expect(subject.get_teams.kind_of?(SportsDataApi::Nfl::Teams)).to be true
    end

    it "returns 32 teams" do
      expect(subject.get_teams.count).to eq 32
    end
  end
end
