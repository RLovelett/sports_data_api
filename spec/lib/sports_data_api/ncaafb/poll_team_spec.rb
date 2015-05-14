require 'spec_helper'

describe SportsDataApi::Ncaafb::PollTeam, vcr: {
    cassette_name: 'sports_data_api_ncaafb_polls',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Ncaafb::Polls }

  context 'results from rankings fetch' do
    let(:polls) do
      SportsDataApi.set_access_level(:ncaafb, 't')
      SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
      SportsDataApi::Ncaafb.rankings(2014, :AP25, 12)
    end

    subject { polls.rankings.first }

    it { should be_an_instance_of(SportsDataApi::Ncaafb::PollTeam) }
    its(:id) { should eq 'MSST' }
    its(:name) { should eq "Bulldogs" }
    its(:market) { should eq 'Mississippi State' }
    its(:points) { should eq 1488 }
    its(:fp_votes) { should eq 48 }
    its(:wins) { should eq 9 }
    its(:losses) { should eq 0 }
    its(:ties) { should eq 0 }
  end
end