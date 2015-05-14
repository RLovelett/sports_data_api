require 'spec_helper'

describe SportsDataApi::Ncaafb, vcr: {
    cassette_name: 'sports_data_api_ncaafb',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:ncaafb, 'invalid_key')
      SportsDataApi.set_access_level(:ncaafb, 't')
    end

    describe '.rankings' do
      it { expect { subject.rankings(2014, :AP25, 22) }.to raise_error(SportsDataApi::Ncaafb::Exception) }
      it { expect { subject.rankings(2014, :AP10, 12) }.to raise_error(SportsDataApi::Ncaafb::Exception) }
    end

    describe '.schedule' do
      it { expect { subject.schedule(2013, :REG) }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.boxscore' do
      it { expect { subject.boxscore(2014, :REG, 10, 'IOW', 'NW') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.weekly' do
      it { expect { subject.weekly(2013, :REG, 1) }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportsdatallc\.org.*/).to_timeout }
    describe '.schedule' do
      it { expect { subject.schedule(2014, :REG) }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.boxscore' do
      it { expect { subject.boxscore(2014, :REG, 9, 'IND', 'MIA') }.to raise_error(SportsDataApi::Exception) }
    end

    describe '.weekly' do
      it { expect { subject.weekly(2014, :REG, 22) }.to raise_error(SportsDataApi::Exception) }
    end
  end
end
