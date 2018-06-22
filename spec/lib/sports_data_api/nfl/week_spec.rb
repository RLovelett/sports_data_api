require 'spec_helper'

describe SportsDataApi::Nfl::Week, vcr: {
    cassette_name: 'sports_data_api_nfl_week',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  context 'results from schedule fetch' do
    let(:season) { SportsDataApi::Nfl.schedule(2012, :REG) }
    let(:week) { season.weeks.first }

    before do
      SportsDataApi.set_access_level(:nfl, 'ot')
      SportsDataApi.set_key(:nfl, api_key(:nfl))
    end

    it 'parses the week from the season' do
      expect(week).to be_a SportsDataApi::Nfl::Week
      expect(week.year).to eq 2012
      expect(week.season).to eq :REG
      expect(week.number).to eq 1
      expect(week.games.count).to eq 16
      expect(week.games.map(&:class).uniq).to eq [SportsDataApi::Nfl::Game]
    end
  end
end
