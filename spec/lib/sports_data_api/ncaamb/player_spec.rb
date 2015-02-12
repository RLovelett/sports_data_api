require 'spec_helper'

describe SportsDataApi::Ncaamb::Player, vcr: {
    cassette_name: 'sports_data_api_ncaamb_player',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
  end
  let(:player) { SportsDataApi::Ncaamb.team_roster('c7569eae-5b93-4197-b204-6f3a62146b25').players.last.player }

  describe 'player' do
    subject { player }
    it 'should have an id' do
      expect(subject[:id]).to eql 'f75e79a3-b9f8-4541-b75e-fb5477c3600f'
    end
    
    it 'should have a status' do
      expect(subject[:status]).to eql 'ACT'
    end

    it 'should have a full_name' do
      expect(subject[:full_name]).to eql 'Sam Dekker'
    end

    it 'should have a first_name' do
      expect(subject[:first_name]).to eql 'Sam'
    end

    it 'should have a last_name' do
      expect(subject[:last_name]).to eql 'Dekker'
    end

    it 'should have an abbr_name' do
      expect(subject[:abbr_name]).to eql 'S.Dekker'
    end

    it 'should have a height' do
      expect(subject[:height]).to eql '81'
    end

    it 'should have a weight' do
      expect(subject[:weight]).to eql '230'
    end

    it 'should have a position' do
      expect(subject[:position]).to eql 'F'
    end

    it 'should have a primary_position' do
      expect(subject[:primary_position]).to eql 'NA'
    end

    it 'should have a jersey_number' do
      expect(subject[:jersey_number]).to eql '15'
    end

    it 'should have an experience' do
      expect(subject[:experience]).to eql 'JR'
    end

    it 'should have a birth_place' do
      expect(subject[:birth_place]).to eql 'SHEBOYGAN, WI, USA'
    end
  end
end
