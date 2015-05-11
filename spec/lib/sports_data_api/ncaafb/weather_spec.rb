require 'spec_helper'

describe SportsDataApi::Ncaafb::Weather, vcr: {
    cassette_name: 'sports_data_api_ncaafb_weather',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:weekly_schedule) do
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi::Ncaafb.weekly(2014, :REG, 4)
  end
  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first.weather }
    its(:temperature) { should eq 79 }
    its(:condition) { should eq 'Sunny' }
    its(:humidity) { should eq 65 }
    its(:wind_speed) { should eq 9 }
    its(:wind_direction) { should eq 'ENE' }
  end
end