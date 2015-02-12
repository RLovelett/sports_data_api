require 'spec_helper'

describe SportsDataApi::Ncaamb::Tournament, vcr: {
    cassette_name: 'sports_data_api_ncaamb_tournament',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:tournament_list) do
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi::Ncaamb.tournament_list(2013, :pst)
  end
  context "tournament" do 
    subject { tournament_list.tournaments.first }
    its(:id) { should eq "541807c8-9a76-4999-a2ad-c0ba8a553c3d" }
    its(:year) { should eq 2013 }
    its(:season) { should eq :PST }
    its(:name) { should eq "NCAA Men's Division I Basketball Tournament" }
    its(:location) { should eq "Arlington, TX, USA" }
    its(:status) { should eq "closed" }
    its(:start_date) { should eq Time.parse("2014-03-18") }
    its(:end_date) { should eq Time.parse("2014-04-07") }
    its(:schedule) { should be_an_instance_of(SportsDataApi::Ncaamb::TournamentSchedule) }
  end
end