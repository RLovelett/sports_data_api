require 'spec_helper'

describe SportsDataApi::Mlb::Season, vcr: {
    cassette_name: 'sports_data_api_mlb_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
      let(:season) do
        SportsDataApi.set_access_level(:mlb, 't')
        SportsDataApi.set_key(:mlb, api_key(:mlb))
        SportsDataApi::Mlb.schedule(2014)
      end

      subject { season }
      its(:games) { should have(2449).games}

  end
end
