require 'spec_helper'

describe SportsDataApi::Mlb::Statistics, vcr: {
  cassette_name: 'sports_data_api_mlb_player_statistics',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  let(:game) {
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.game('4f46825d-8172-47bc-9f06-2a162c330ffb')
  }
  let(:players) { game.away.players }

  context 'when hitter' do
    let(:player) do
      players.find do |p|
        p[:first_name] == 'Elvis' && p[:last_name] == 'Andrus'
      end
    end
    subject { player.statistics }

    its(:pitching) { should be_nil }
    its(:fielding) { should be_instance_of(SportsDataApi::Mlb::MergedStats) }
    its(:hitting) { should be_instance_of(SportsDataApi::Mlb::MergedStats) }
  end

  context 'when dh' do
    let(:player) do
      players.find do |p|
        p[:first_name] == 'Joseph' && p[:last_name] == 'Gallo'
      end
    end
    subject { player.statistics }

    its(:pitching) { should be_nil }
    its(:fielding) { should be_nil }
    its(:hitting) { should be_instance_of(SportsDataApi::Mlb::MergedStats) }
  end

  context 'when pitcher' do
    let(:player) do
      players.find do |p|
        p[:first_name] == 'Yu' && p[:last_name] == 'Darvish'
      end
    end
    subject { player.statistics }

    its(:pitching) { should be_instance_of(SportsDataApi::Mlb::MergedStats) }
    its(:fielding) { should be_instance_of(SportsDataApi::Mlb::MergedStats) }
    its(:hitting) { should be_nil }
  end
end
