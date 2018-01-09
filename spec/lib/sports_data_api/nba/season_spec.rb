require 'spec_helper'

describe SportsDataApi::Nba::Season, vcr: {
    cassette_name: 'sports_data_api_nba_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Nba::Season }
  describe '.valid?' do
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
        SportsDataApi.set_access_level(:nba, 'trial')
        SportsDataApi.set_key(:nba, api_key(:nba))
        SportsDataApi::Nba.schedule(2017, :reg)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Nba::Season) }
      its(:id) { should eq '7dcb5184-ab33-49fe-bd18-c4ca2b1cfc08' }
      its(:year) { should eq 2017 }
      its(:type) { should eq :REG }
      its(:games) { should have(1230).games }
  end
end
