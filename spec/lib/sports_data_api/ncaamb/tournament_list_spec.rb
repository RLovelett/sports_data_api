require 'spec_helper'

describe SportsDataApi::Ncaamb::TournamentList, vcr: {
    cassette_name: 'sports_data_api_ncaamb_tournament_list',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Ncaamb::TournamentList }
  describe '.valid?' do
    context :CT do
      it { SportsDataApi::Ncaamb::TournamentList.valid?(:CT).should eq(true) }
    end
    context :REG do
      it { subject.valid?(:REG).should eq(true) }
    end
    context :PST do
      it { subject.valid?(:PST).should eq(true) }
    end
    context :ct do
      it { subject.valid?(:ct).should eq(false) }
    end
    context :reg do
      it { subject.valid?(:reg).should eq(false) }
    end
    context :pst do
      it { subject.valid?(:pst).should eq(false) }
    end
  end
  context 'results from tournament list fetch' do
    let(:tournament_list) do
      SportsDataApi.set_access_level(:ncaamb, 't')
      SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
      SportsDataApi::Ncaamb.tournament_list(2013, :pst)
    end
    subject { tournament_list }
    it { should be_an_instance_of(SportsDataApi::Ncaamb::TournamentList) }
    its(:id) { should eq "203f9d87-c0ed-46fa-ac8e-1b83ea4f3ad8" }
    its(:year) { should eq 2013 }
    its(:season) { should eq :PST }
    its(:tournaments) { should have(4).tournaments }
  end
end
