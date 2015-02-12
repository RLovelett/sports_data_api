require 'spec_helper'

describe SportsDataApi::Ncaamb::Game, vcr: {
    cassette_name: 'sports_data_api_ncaamb_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.schedule(2014, :REG)
  end
  let(:game_summary) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.game_summary('0b387f08-6c3d-4d82-987e-e0fc3ab151d6')
  end
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi::Ncaamb.daily(2015, 2, 25)
  end
  context 'results from schedule fetch' do
    subject { season.games.first }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    its(:id) { should eq '0c39bdcf-d6d4-4090-8280-2ed25fe6b23e' }
    its(:scheduled) { should eq Time.new(2014, 11, 14, 11, 00, 00, '-05:00') }
    its(:home) { should eq '54df21af-8f65-42fc-bc01-8bf750856d70' }
    its(:away) { should eq 'eb157f98-0697-459c-9293-ddb162ceb28b' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaamb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaamb::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
  context 'results from game_summary fetch' do
    subject { game_summary }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    its(:id) { should eq '0b387f08-6c3d-4d82-987e-e0fc3ab151d6' }
    its(:scheduled) { should eq Time.new(2015, 2, 07, 17, 30, 00, '-05:00') }
    its(:home) { should eq 'c7569eae-5b93-4197-b204-6f3a62146b25' }
    its(:away) { should eq '4b7dedc0-7b48-49a4-aad6-8a94a33274d2' }
    its(:status) { should eq 'closed' }
    its(:half) { should eq 2 }
    its(:clock) { should eq '00:00' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaamb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaamb::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    its(:id) { should eq '219e5826-cae0-4d60-ab43-6076722524cf' }
    its(:scheduled) { should eq Time.new(2015, 2, 25, 19, 00, 00, '-05:00') }
    its(:home) { should eq '9b66e1e0-aace-4671-9be2-54c8acf5ecfc' }
    its(:away) { should eq 'c1c1e6df-a383-4fbd-ba7b-32d4f9ef9518' }
    its(:status) { should eq 'scheduled' }
    its(:half) { should eq nil }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaamb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaamb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaamb::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Ncaamb::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
end