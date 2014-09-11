require 'spec_helper'

describe SportsDataApi::Nhl::Game, vcr: {
    cassette_name: 'sports_data_api_nhl_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi::Nhl.schedule(2013, :REG)
  end
  let(:game_summary) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi::Nhl.game_summary('f0f7e327-3a3a-410b-be75-0956c90c4988')
  end
  let(:daily_schedule) do
    SportsDataApi.set_access_level(:nhl, 't')
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi::Nhl.daily(2013, 12, 12)
  end
  context 'results from schedule fetch' do
    subject { season.games.first }
    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq 'f0f7e327-3a3a-410b-be75-0956c90c4988' }
    its(:scheduled) { should eq Time.new(2013, 10, 01, 16, 00, 00, '-07:00') }
    its(:home) { should eq '441713b7-0f24-11e2-8525-18a905767e44' }
    its(:away) { should eq '441730a9-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nhl::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
  context 'results from game_summary fetch' do
    subject { game_summary }
    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq 'f0f7e327-3a3a-410b-be75-0956c90c4988' }
    its(:scheduled) { should eq Time.new(2013, 10, 01, 16, 00, 00, '-07:00') }
    its(:home) { should eq '441713b7-0f24-11e2-8525-18a905767e44' }
    its(:away) { should eq '441730a9-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:period) { should eq nil }
    its(:clock) { should eq "00:00" }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nhl::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
  context 'results from daily schedule fetch' do
    subject { daily_schedule.first }
    it { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    its(:id) { should eq 'abffac54-dc1e-4f2f-abe5-8c19a87cdad7' }
    its(:scheduled) { should eq Time.new(2013, 12, 12, 16, 00, 00, '-08:00') }
    its(:home) { should eq '44179d47-0f24-11e2-8525-18a905767e44' }
    its(:away) { should eq '441713b7-0f24-11e2-8525-18a905767e44' }
    its(:status) { should eq 'closed' }
    its(:period) { should eq nil }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Nhl::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Nhl::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Nhl::Broadcast) }
    its(:summary) { should be_an_instance_of(SportsDataApi::Nhl::Game) }
    it '#boxscore' do
      expect { subject.boxscore }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
  end
end
