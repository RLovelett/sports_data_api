require 'spec_helper'

describe SportsDataApi::Nfl::Season, vcr: {
    cassette_name: 'sports_data_api_nfl_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Nfl::Season }
  describe '.season?' do
    context :PRE do
      it { SportsDataApi::Nfl::Season.valid?(:PRE).should eq(true) }
    end
    context :REG do
      it { subject.valid?(:REG).should eq(true) }
    end
    context :PST do
      it { subject.valid?(:PST).should eq(true) }
    end
    context :pre do
      it { subject.valid?(:pre).should eq(false) }
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
        SportsDataApi.set_access_level(:nfl, 't')
        SportsDataApi.set_key(:nfl, api_key(:nfl))
        SportsDataApi::Nfl.schedule(2012, :REG)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Nfl::Season) }
      its(:year) { should eq 2012 }
      its(:type) { should eq :REG }
      its(:weeks) { should have(17).weeks }
  end
end
