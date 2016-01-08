require 'spec_helper'

describe SportsDataApi::Ncaafb::PlayByPlay, vcr: {
    cassette_name: 'sports_data_api_ncaafb_play_by_play',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do

  let(:play_by_play) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.play_by_play(2014, :REG, 10, 'IOW', 'NW')
  end

  context 'results for play by play fetch' do
    subject { play_by_play }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::PlayByPlay) }
    its(:id) { should eq 'f38cb305-28e8-446e-ac4a-c36fe7f823ea' }
    its(:scheduled) { should eq Time.new(2014, 11, 1, 16, 00, 00, '+00:00') }

    its(:home) { should eq 'IOW' }
    its(:away) { should eq 'NW' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
  end

  context 'game quarters in play by play results' do
    subject {
      play_by_play.quarters.first
    }
    its(:number) { should eq 1 }
  end

  context 'pbp data in play by play results' do
    subject {
      play_by_play.quarters.first.play_by_plays.first
    }

    its(:class) {should eq(SportsDataApi::Ncaafb::Event)}
    its(:type) {should eq("event")}
    its(:sequence) {should eq(1)}
    its(:clock) {should eq("15:00")}
    its(:updated) {should eq("2014-11-01T16:01:56+00:00")}
    its(:summary) {should eq("IOW wins coin toss, elects to receive.")}
    its(:winner) {should eq({"team"=>"IOW", "outcome"=>"receive"})}
    its(:event_type) {should eq("cointoss")}
  end

  context 'pbp data in play by play results' do
    subject {
      play_by_play.quarters.first.play_by_plays.detect {|i| i.class == SportsDataApi::Ncaafb::Drive}
    }

    its(:class) {should eq(SportsDataApi::Ncaafb::Drive)}
    its(:type) {should eq("drive")}
    its(:id) {should eq("a211be88-0736-4951-ab87-fb4c09d2b265")}
    its(:clock) {should eq("15:00")}
    its(:team) {should eq("IOW")}
    its(:actions) {should be_any}
  end

  context 'play actions data in play by play results' do
    subject {
      play_by_play.quarters.first.play_by_plays.select {|i| i.class == SportsDataApi::Ncaafb::Drive}.flatten.map(&:actions).flatten.select {|a| a.sequence == 2}.first
    }

    its(:class) {should eq(SportsDataApi::Ncaafb::PlayAction)}
    its(:sequence) {should eq(2)}
    its(:clock) {should eq("15:00")}
    its(:id) {should eq "2e66a6cd-15a9-4d68-86da-9d518a3244c1" }
    its(:clock) {should eq("15:00")}
    its(:type) {should eq("play")}
    its(:summary) {should eq("8-J.Mitchell kicks 65 yards from NW 35. 10-J.Parker to NW 46 for 54 yards.")}
    its(:updated) {should eq("2014-11-01T16:07:10+00:00")}
    its(:side) {should eq("NW")}
    its(:yard_line) {should eq(35)}
    its(:down) {should eq(1)}
    its(:details) {should eq("/2014/REG/10/NW/IOW/plays/2e66a6cd-15a9-4d68-86da-9d518a3244c1.json")}
    its(:play_type) {should eq("kick")}
    its(:sequence) {should eq(2)}
    its(:yfd) {should eq(10)}
  end

  context 'event actions data in play by play results' do
    subject {
      play_by_play.quarters.first.play_by_plays.select {|i| i.class == SportsDataApi::Ncaafb::Drive}.flatten.map(&:actions).flatten.select {|a| a.sequence == 52}.first
    }

    its(:class) {should eq(SportsDataApi::Ncaafb::EventAction)}
    its(:clock) {should eq(":00")}
    its(:sequence) {should eq(52)}
    its(:id) {should eq "e6dda90f-426a-425f-9995-f793a9e54383" }
    its(:type) {should eq("event")}
    its(:summary) {should eq("End of Quarter")}
    its(:updated) {should eq("2014-11-01T16:43:17+00:00")}
    its(:event_type) {should eq("quarterend")}
  end
end
