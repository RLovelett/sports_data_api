require 'spec_helper'

describe SportsDataApi::Ncaamb::TournamentGame, vcr: {
    cassette_name: 'sports_data_api_ncaamb_tournament_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:tournament_schedule) do
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi::Ncaamb.tournament_schedule(2013, :PST, "541807c8-9a76-4999-a2ad-c0ba8a553c3d")
  end
  context 'results from tournament schedule' do
    subject { tournament_schedule.games[5] }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::TournamentGame) }
    its(:id) { should eq '0e038bb9-cf2a-4920-8a14-7b4e7a61b736' }
    its(:round_number) { should eq 5 }
    its(:round_name) { should eq 'Elite 8' }
    its(:bracket) { should eq 'West Regional' }
    its(:year) { should eq 2013 }
    its(:season) { should eq :PST }
    its(:scheduled) { should eq Time.new(2014, 3, 29, 20, 49, 00, '-04:00') }
    its(:home) { should eq '9b166a3f-e64b-4825-bb6b-92c6f0418263' }
    its(:away) { should eq 'c7569eae-5b93-4197-b204-6f3a62146b25' }
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
end