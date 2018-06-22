require 'spec_helper'

describe SportsDataApi::Nfl::Venue, vcr: {
    cassette_name: 'sports_data_api_nfl_venue',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 'ot')
  end

  describe 'when venue comes from .team_roster' do
    let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
    let(:base) { SportsDataApi::Nfl.team_roster(team_id) }
    let(:venue) { base.venue }

    it 'parses out the venue data' do
      expect(venue[:id]).to eq 'f5ff00d4-1ed8-4918-bf73-13d66d510f98'
      expect(venue[:name]).to eq 'U.S. Bank Stadium'
      expect(venue[:city]).to eq 'Minneapolis'
      expect(venue[:state]).to eq 'MN'
      expect(venue[:country]).to eq 'USA'
      expect(venue[:zip]).to eq '55415'
      expect(venue[:address]).to eq '900 S 5th St'
      expect(venue[:capacity]).to eq 66200
      expect(venue[:surface]).to eq 'turf'
      expect(venue[:roof_type]).to eq 'dome'
    end
  end

  describe 'when venue comes from .teams' do
    let(:team_id) { '33405046-04ee-4058-a950-d606f8c30852' }
    let(:base) { SportsDataApi::Nfl.teams }
    let(:team) { base.teams.detect { |t| t.id == team_id } }
    let(:venue) { team.venue }

    it 'parses out the venue data' do
      expect(venue[:id]).to eq 'f5ff00d4-1ed8-4918-bf73-13d66d510f98'
      expect(venue[:name]).to eq 'U.S. Bank Stadium'
      expect(venue[:city]).to eq 'Minneapolis'
      expect(venue[:state]).to eq 'MN'
      expect(venue[:country]).to eq 'USA'
      expect(venue[:zip]).to eq '55415'
      expect(venue[:address]).to eq '900 S 5th St'
      expect(venue[:capacity]).to eq 66200
      expect(venue[:surface]).to eq 'turf'
      expect(venue[:roof_type]).to eq 'dome'
    end
  end
end
