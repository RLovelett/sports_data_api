require 'spec_helper'

describe SportsDataApi::Mlb::Player, vcr: {
  cassette_name: 'sports_data_api_mlb_player',
  record: :new_episodes,
  match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
  end

  let(:player) do
    SportsDataApi::Mlb.team_roster(Date.today.year).first.player
  end

describe 'player' do
    subject { player }
    it 'should have an team_id' do
      expect(subject[:team_id]).to eql 'ef64da7f-cfaf-4300-87b0-9313386b977c'
    end

    it 'should have a status' do
      expect(subject[:status]).to eql 'A'
    end

    it 'should have a jersey' do
      expect(subject[:jersey]).to eql '31'
    end

    it 'should have a position' do
      expect(subject[:position]).to eql 'C'
    end

    it 'should have a primary_position' do
      expect(subject[:primary_position]).to eql 'C'
    end

    it 'should have an id' do
      expect(subject[:id]).to eql 'f7deada3-d11e-490e-8658-ae83b7612014'
    end

    it 'should have a mlbam_id' do
      expect(subject[:mlbam_id]).to eql '460077'
    end

    it 'should have a last_name' do
      expect(subject[:last_name]).to eql 'Butera'
    end

    it 'should have a first_name' do
      expect(subject[:first_name]).to eql 'Andrew'
    end

    it 'should have an preferred_name' do
      expect(subject[:preferred_name]).to eql 'Drew'
    end

    it 'should have an bat_hand' do
      expect(subject[:bat_hand]).to eql 'R'
    end

    it 'should have an throw_hand' do
      expect(subject[:throw_hand]).to eql 'R'
    end

    it 'should have a weight' do
      expect(subject[:weight]).to eql '200'
    end

    it 'should have a height' do
      expect(subject[:height]).to eql '601'
    end

    it 'should have a birthdate' do
      expect(subject[:birthdate]).to eql '1983-08-09'
    end

    it 'should have a birthcity' do
      expect(subject[:birthcity]).to eql 'Evansville'
    end

    it 'should have a birthstate' do
      expect(subject[:birthstate]).to eql 'IL'
    end

    it 'should have a birthcountry' do
      expect(subject[:birthcountry]).to eql 'USA'
    end

    it 'should have a highschool' do
      expect(subject[:highschool]).to eql 'Bishop Moore, Orlando, FL'
    end

    it 'should have a college' do
      expect(subject[:college]).to eql 'Central Florida'
    end

    it 'should have a pro_debut' do
      expect(subject[:pro_debut]).to eql '2010-04-09'
    end
  end
end
