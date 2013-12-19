require 'spec_helper'

describe SportsDataApi::Nfl::Weather, vcr: {
    cassette_name: 'sports_data_api_nfl_weather',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.access_level = 't'
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi::Nfl.weekly(2011, :PST, 4)
  end
  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.weather }
    its(:temperature) { should eq 41 }
    its(:condition) { should eq 'Clear' }
    its(:humidity) { should eq 62 }
    its(:wind_speed) { should eq 4 }
    its(:wind_direction) { should eq 'N' }
  end
end