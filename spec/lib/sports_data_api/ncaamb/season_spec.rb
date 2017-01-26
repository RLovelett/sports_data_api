require 'spec_helper'

describe SportsDataApi::Ncaamb::Season, vcr: {
    cassette_name: 'sports_data_api_ncaamb_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Ncaamb::Season }
  describe '.season?' do
    context :CT do
      it { SportsDataApi::Ncaamb::Season.valid?(:CT).should eq(true) }
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
  context 'results from schedule fetch' do
      let(:season) do
        SportsDataApi.set_access_level(:ncaamb, 't')
        SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
        SportsDataApi::Ncaamb.schedule(2014, :reg)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Ncaamb::Season) }
      its(:year) { should eq 2014 }
      its(:type) { should eq :REG }
      its(:games) { should have(5512).games }
  end
end
