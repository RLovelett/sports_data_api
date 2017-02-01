require 'spec_helper'

describe SportsDataApi::Nhl::Player, vcr: {
    cassette_name: 'sports_data_api_nhl_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'ot')
  end
  let(:player) { SportsDataApi::Nhl.team_roster('441713b7-0f24-11e2-8525-18a905767e44').players.first.player }

  describe 'player' do
    subject { player }
    it 'should have an id' do
      expect(subject[:id]).to eq '3d1e8155-8371-11e2-a3e0-f4ce4684ea4c'
    end

    it 'should have a status' do
      expect(subject[:status]).to eq 'ACT'
    end

    it 'should have a full_name' do
      expect(subject[:full_name]).to eq 'Brian Flynn'
    end

    it 'should have a first_name' do
      expect(subject[:first_name]).to eq 'Brian'
    end

    it 'should have a last_name' do
      expect(subject[:last_name]).to eq 'Flynn'
    end

    it 'should have an abbr_name' do
      expect(subject[:abbr_name]).to eq 'B.Flynn'
    end

    it 'should have a handedness' do
      expect(subject[:handedness]).to eq 'R'
    end

    it 'should have a position' do
      expect(subject[:position]).to eq 'F'
    end

    it 'should have a primary_position' do
      expect(subject[:primary_position]).to eq 'LW'
    end

    it 'should have a jersey_number' do
      expect(subject[:jersey_number]).to eq '32'
    end
  end
end
