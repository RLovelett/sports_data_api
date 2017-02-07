require 'spec_helper'

describe SportsDataApi::Golf::Season do
  subject { SportsDataApi::Golf::Season }
  describe '.season', vcr: {
    cassette_name: 'sports_data_api_golf_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
  } do
    context 'results from season fetch' do
      let(:season) do
        SportsDataApi.set_access_level(:golf, 't')
        SportsDataApi.set_key(:golf, api_key(:golf))
        SportsDataApi::Golf.season(:pga, 2016)
      end
      subject { season }
      it { should be_an_instance_of(SportsDataApi::Golf::Season) }
      its(:year) { should eq 2016 }
      its(:tour) { should eq :pga }
      its(:tournaments) { should have(48).tournaments }
    end
  end
end
