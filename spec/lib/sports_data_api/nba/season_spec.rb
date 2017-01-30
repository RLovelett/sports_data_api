require 'spec_helper'

describe SportsDataApi::Nba::Season, vcr: {
    cassette_name: 'sports_data_api_nba_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Nba::Season }
  describe '.season?' do
    context :PRE do
      it { SportsDataApi::Nba::Season.valid?(:PRE).should eq(true) }
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
        SportsDataApi.set_access_level(:nba, 't')
        SportsDataApi.set_key(:nba, api_key(:nba))
        SportsDataApi::Nba.schedule(2013, :reg)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Nba::Season) }
      its(:year) { should eq 2013 }
      its(:type) { should eq :REG }
      its(:games) { should have(1230).games }
  end
end
