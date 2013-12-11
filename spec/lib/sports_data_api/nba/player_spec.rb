require 'spec_helper'

describe SportsDataApi::Nba::Player, vcr: {
    cassette_name: 'sports_data_api_nba_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.access_level = 't'
  end
  let(:player) { SportsDataApi::Nba.team_roster('583ec825-fb46-11e1-82cb-f4ce4684ea4c').players.first.player }

  describe 'player' do
    subject { player }
    it 'should have an id' do
      expect(subject[:id]).to eql '17973022-bb81-427f-905e-86d3d3d9b51f'
    end
    
    it 'should have a status' do
      expect(subject[:status]).to eql 'ACT'
    end

    it 'should have a full_name' do
      expect(subject[:full_name]).to eql 'Festus Ezeli'
    end

    it 'should have a first_name' do
      expect(subject[:first_name]).to eql 'Festus'
    end

    it 'should have a last_name' do
      expect(subject[:last_name]).to eql 'Ezeli'
    end

    it 'should have an abbr_name' do
      expect(subject[:abbr_name]).to eql 'F.Ezeli'
    end

    it 'should have a height' do
      expect(subject[:height]).to eql '83'
    end

    it 'should have a weight' do
      expect(subject[:weight]).to eql '255'
    end

    it 'should have a position' do
      expect(subject[:position]).to eql 'C'
    end

    it 'should have a primary_position' do
      expect(subject[:primary_position]).to eql 'C'
    end

    it 'should have a jersey_number' do
      expect(subject[:jersey_number]).to eql '31'
    end

    it 'should have an experience' do
      expect(subject[:experience]).to eql '1'
    end

    it 'should have a college' do
      expect(subject[:college]).to eql 'Vanderbilt'
    end

    it 'should have a birth_place' do
      expect(subject[:birth_place]).to eql 'Benin City,, NGA'
    end
  end
end
