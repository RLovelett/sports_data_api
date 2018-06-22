require 'spec_helper'

describe SportsDataApi::Nfl::Season, vcr: {
    cassette_name: 'sports_data_api_nfl_season',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  subject { SportsDataApi::Nfl::Season }

  context 'results from .schedule' do
    let(:season) { SportsDataApi::Nfl.schedule(2012, :REG) }

    before do
      SportsDataApi.set_access_level(:nfl, 'ot')
      SportsDataApi.set_key(:nfl, api_key(:nfl))
    end

    it 'parses out the season' do
      expect(season).to be_a SportsDataApi::Nfl::Season
      expect(season.year).to eq 2012
      expect(season.type).to eq :REG
      expect(season.weeks.count).to eq 17
      expect(season.weeks.map(&:class).uniq).to eq [SportsDataApi::Nfl::Week]
    end
  end
end
