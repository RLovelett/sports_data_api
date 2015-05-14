require 'spec_helper'

describe SportsDataApi::Ncaafb::Polls, vcr: {
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

    subject { polls }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Polls) }
    its(:id) { should eq 'AP25' }
    its(:name) { should eq "Associated Press Top 25" }
    its(:season_type) { should eq 'REG' }
    its(:rankings) { should have(25).rankings }
    its(:candidates) { should have(11).candidates }
  end
end