require 'spec_helper'

describe SportsDataApi::Mlb::Game, vcr: {
    cassette_name: 'sports_data_api_mlb_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.schedule(2014)
  end
  context 'results from schedule fetch' do
    subject { season.games.first }
    it { should be_an_instance_of(SportsDataApi::Mlb::Game) }
    its(:id) { should eq '00372cd7-911b-42e7-a509-bb555f747a9d' }
    its(:scheduled) { should eq Time.parse("2014-09-14T20:10:00Z") }
    its(:home) { should eq '25507be1-6a68-4267-bd82-e097d94b359b' }
    its(:away) { should eq 'd52d5339-cbdd-43f3-9dfa-a42fd588b9a3' }
    its(:status) { should eq 'scheduled' }
    its(:venue) { should eq 'bf05de0d-7ced-4a19-8e17-2bbd985f8a92' }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Mlb::Broadcast) }
  end
end
