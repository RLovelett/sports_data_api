require 'spec_helper'

describe SportsDataApi::Golf::Summary, vcr: {
  cassette_name: 'sports_data_api_golf_summary',
  record: :once,
  match_requests_on: [:path]
} do
  before do
    SportsDataApi.set_access_level(:golf, 't')
    SportsDataApi.set_key(:golf, api_key(:golf))
  end

  subject { SportsDataApi::Golf.summary(:pga, 2016, 'b95ab96b-9a0b-4309-880a-ad063cb163ea') }

  its(:tour) { should eq(:pga) }
  its(:year) { should eq(2016) }
  its(:name) { should eq('The Masters') }
  its(:purse) { should eq(9_000_000.0) }
  its(:winning_share) { should eq(1_620_000.0) }
  its(:currency) { should eq('USD') }
  its(:points) { should eq(600) }
  its(:event_type) { should eq('stroke') }
  its(:start_date) { should eq('2015-04-09') }
  its(:end_date) { should eq('2015-04-12') }
  its(:course_timezone) { should eq('US/Eastern') }
  its(:coverage) { should eq('full') }
  its(:status) { should eq('closed') }

  describe '#field' do
    it 'parses the field players' do
      field = subject.field
      expect(field.length).to eq 97
      player = field.first
      expect(player).to be_an_instance_of(SportsDataApi::Golf::Player)
      expect(player[:id]).to eq 'a0678900-eda0-4d5f-87ab-6c1c941596cd'
      expect(player[:first_name]).to eq 'Sang-Moon'
      expect(player[:last_name]).to eq 'Bae'
      expect(player[:country]).to eq 'SOUTH KOREA'
    end
  end

  describe '#rounds' do
    it 'parses the rounds' do
      rounds = subject.rounds
      expect(rounds.length).to eq 4
      round = rounds.first
      expect(round).to be_an_instance_of(SportsDataApi::Golf::Round)
    end
  end
end

