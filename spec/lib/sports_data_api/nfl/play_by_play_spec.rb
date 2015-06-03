require 'spec_helper'

describe SportsDataApi::Nfl::PlayByPlay, vcr: {
    cassette_name: 'sports_data_api_nfl_play_by_play',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do

  let(:play_by_play) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
    SportsDataApi::Nfl.play_by_play(2012, :REG, 1, 'NYG', 'DAL')
  end

  context 'results for play by play fetch' do
    subject { play_by_play }
    it { should be_an_instance_of(SportsDataApi::Nfl::PlayByPlay) }
    its(:id) { should eq '8c0bce5a-7ca2-41e5-9838-d1b8c356ddc3' }
    its(:scheduled) { should eq Time.new(2012, 9, 5, 19, 30, 00, '-05:00') }
    its(:home) { should eq 'NYG' }
    its(:away) { should eq 'DAL' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
  end

  context 'game quarters in play by play results' do
    subject {
      play_by_play.quarters.first
    }
    its(:number) { should eq 1 }
  end

  context 'pbp data in play by play results' do
    subject {
      play_by_play.quarters.first.pbps.first
    }

    its(:class) {should eq(SportsDataApi::Nfl::Event)}
    its(:type) {should eq("event")}
  end

  context 'pbp data in play by play results' do
    subject {
      play_by_play.quarters.first.pbps.detect {|i| i.class == SportsDataApi::Nfl::Drive}
    }

    its(:class) {should eq(SportsDataApi::Nfl::Drive)}
    its(:type) {should eq("drive")}
    its(:id) {should eq("0a2b79b8-62c9-4584-a103-accd0700f831")}
    its(:clock) {should eq("15:00")}
    its(:team) {should eq("NYG")}
    its(:actions) {should be_any}
  end

  context 'play actions data in play by play results' do
    subject {
      play_by_play.quarters.first.pbps.select {|i| i.class == SportsDataApi::Nfl::Drive}.flatten.map(&:actions).map(&:actions).flatten.detect {|a| a.sequence == 2}
    }

    its(:class) {should eq(SportsDataApi::Nfl::PlayAction)}
    its(:sequence) {should eq(2)}
    its(:clock) {should eq("15:00")}
    its(:id) {should eq "fdec3736-3598-4cde-ad4c-7270afc6d4e7" }
    its(:clock) {should eq("15:00")}
    its(:type) {should eq("play")}
    its(:summary) {should eq("5-D.Bailey kicks 69 yards from DAL 35. 22-D.Wilson to NYG 16 for 20 yards (15-A.Holmes).")}
    its(:updated) {should eq("2012-09-06T00:42:24+00:00")}
    its(:side) {should eq("DAL")}
    its(:yard_line) {should eq(35)}
    its(:down) {should eq(1)}
    its(:details) {should eq("/2012/REG/1/DAL/NYG/plays/fdec3736-3598-4cde-ad4c-7270afc6d4e7.json")}
    its(:play_type) {should eq("kick")}
    its(:sequence) {should eq(2)}
    its(:yfd) {should eq(10)}
  end

  context 'play actions data in play by play results' do
    subject {
      play_by_play.quarters.first.pbps.select {|i| i.class == SportsDataApi::Nfl::Drive}.flatten.map(&:actions).map(&:actions).flatten.select {|a| a.class == SportsDataApi::Nfl::EventAction}.first
    }

    its(:class) {should eq(SportsDataApi::Nfl::EventAction)}
    its(:clock) {should eq(":00")}
    its(:sequence) {should eq(34)}
    its(:id) {should eq "59f4431e-5584-4199-ab7e-5cb29c89cbd4" }
    its(:type) {should eq("event")}
    its(:summary) {should eq("End of Quarter")}
    its(:updated) {should eq("2012-09-06T01:11:56+00:00")}
    its(:event_type) {should eq("quarterend")}
  end
end
