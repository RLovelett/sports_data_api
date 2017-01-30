require 'spec_helper'

describe SportsDataApi::Ncaafb::Season, vcr: {
    cassette_name: 'sports_data_api_ncaafb_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Ncaafb::Season }
  describe '.season?' do

    context :REG do
      it { subject.valid?(:REG).should eq(true) }
    end
    context :reg do
      it { subject.valid?(:reg).should eq(false) }
    end
  end

  context 'results from schedule fetch' do
      let(:season) do
        SportsDataApi.set_access_level(:ncaafb, 't')
        SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
        SportsDataApi::Ncaafb.schedule(2014, :REG)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Ncaafb::Season) }
      its(:year) { should eq 2014 }
      its(:type) { should eq :REG }
      its(:weeks) { should have(21).weeks }
  end
end
