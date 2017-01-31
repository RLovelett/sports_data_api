require 'spec_helper'

describe SportsDataApi::Ncaafb::Game, vcr: {
    cassette_name: 'sports_data_api_golf_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_access_level(:golf, 't')
    SportsDataApi.set_key(:golf, api_key(:golf))
    SportsDataApi::Golf.season(:pga, 2016)
  end
  let(:tournaments) { season.tournaments }

  context 'results from schedule fetch' do
    subject { tournaments.first }
    it { should be_an_instance_of(SportsDataApi::Golf::Tournament) }
    its(:year) { should eq 2016 }
    its(:tour) { should eq :pga }
    its(:id) { should eq '3c7adaa3-856a-4858-a73c-4c784c8f635f' }
    its(:name) { should eq 'Frys.com Open' }
    its(:event_type) { should eq 'stroke' }
    its(:purse) { should eq 6000000.0 }
    its(:winning_share) { should eq 1080000.0 }
    its(:currency) { should eq 'USD' }
    its(:points) { should eq 500 }
    its(:course_timezone) { should eq 'US/Pacific' }
    its(:start_date) { should eq Date.new(2015, 10, 15) }
    its(:end_date) { should eq Date.new(2015, 10, 18) }
  end

  describe '#summary' do
    it 'fetches the Golf.summary' do
      tournament = tournaments.first
      summary = instance_double SportsDataApi::Golf::Summary
      allow(SportsDataApi::Golf).to receive(:summary) { summary }

      expect(tournament.summary).to eq summary
      expect(SportsDataApi::Golf).to have_received(:summary).with(
        tournament.tour, tournament.year, tournament.id, SportsDataApi::Golf::DEFAULT_VERSION)
    end
  end
end
