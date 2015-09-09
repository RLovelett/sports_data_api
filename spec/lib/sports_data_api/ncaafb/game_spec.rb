require 'spec_helper'

describe SportsDataApi::Ncaafb::Game, vcr: {
    cassette_name: 'sports_data_api_ncaafb_game',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:season) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.schedule(2014, :REG)
  end

  let(:boxscore) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.boxscore(2014, :REG, 10, 'IOW', 'NW')
  end

  let(:game_statistics) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.game_statistics(2014, :REG, 10, 'IOW', 'NW')
  end
  let(:weekly_schedule) do
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi::Ncaafb.weekly(2014, :REG, 1)
  end

  let(:game_roster) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.game_roster(2014, :REG, 10, 'IOW', 'NW')
  end

  context 'results from schedule fetch' do
    subject { season.weeks.first.games.first }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:id) { should eq '92044ce9-3698-443d-88a9-47967462dd61' }
    its(:scheduled) { should eq Time.new(2014, 8, 23, 19, 30, 00, '+00:00') }
    its(:home) { should eq 'EW' }
    its(:away) { should eq 'SHS' }
    its(:status) { should eq 'closed' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaafb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaafb::Broadcast) }
    its(:weather) { should be_an_instance_of(SportsDataApi::Ncaafb::Weather) }
    it '#summary' do
      expect { subject.summary }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
    it '#injuries' do
      expect { subject.injuries }.to raise_error(NotImplementedError)
    end
    it '#depthchart' do
      expect { subject.depthchart }.to raise_error(NotImplementedError)
    end

    its(:boxscore) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:statistics) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:roster) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
  end

  context 'results from boxscore fetch' do
    subject { boxscore }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:id) { should eq 'f38cb305-28e8-446e-ac4a-c36fe7f823ea' }
    its(:scheduled) { should eq Time.new(2014, 11, 1, 16, 00, 00, '+00:00') }
    its(:home) { should eq 'IOW' }
    its(:away) { should eq 'NW' }
    its(:status) { should eq 'closed' }
    its(:quarter) { should eq 4 }
    its(:clock) { should eq ':00' }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaafb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaafb::Broadcast) }
    its(:weather) { should be_an_instance_of(SportsDataApi::Ncaafb::Weather) }
    it '#summary' do
      expect { subject.summary }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
    it '#injuries' do
      expect { subject.injuries }.to raise_error(NotImplementedError)
    end
    it '#depthchart' do
      expect { subject.depthchart }.to raise_error(NotImplementedError)
    end

    its(:boxscore) { should be_an_instance_of(SportsDataApi::Ncaafb::Game)}
    its(:statistics) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:roster) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
  end

  context 'results from weekly schedule fetch' do
    subject { weekly_schedule.first }
    it { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:id) { should eq '92044ce9-3698-443d-88a9-47967462dd61' }
    its(:scheduled) { should eq Time.new(2014, 8, 23, 19, 30, 00, '+00:00') }
    its(:home) { should eq 'EW' }
    its(:away) { should eq 'SHS' }
    its(:status) { should eq 'closed' }
    its(:quarter) { should eq 0 }
    its(:clock) { should eq nil }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:venue) { should be_an_instance_of(SportsDataApi::Ncaafb::Venue) }
    its(:broadcast) { should be_an_instance_of(SportsDataApi::Ncaafb::Broadcast) }
    its(:weather) { should be_an_instance_of(SportsDataApi::Ncaafb::Weather) }
    it '#summary' do
      expect { subject.summary }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
    it '#injuries' do
      expect { subject.injuries }.to raise_error(NotImplementedError)
    end
    it '#depthchart' do
      expect { subject.depthchart }.to raise_error(NotImplementedError)
    end
    its(:boxscore) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:statistics) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:roster) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
  end

  context 'results from game statistics fetch' do
    subject { game_statistics }
    its(:id) { should eq 'f38cb305-28e8-446e-ac4a-c36fe7f823ea' }
    its(:status) { should eq 'closed' }
    its(:scheduled) { should eq Time.new(2014, 11, 01, 16, 00, 00, '+00:00') }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }

    it '#summary' do
      expect { subject.summary }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
    it '#injuries' do
      expect { subject.injuries }.to raise_error(NotImplementedError)
    end
    it '#depthchart' do
      expect { subject.depthchart }.to raise_error(NotImplementedError)
    end
    its(:boxscore) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    its(:roster) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
  end

  context 'results from game roster fetch' do
    subject { game_roster }
    its(:id) { should eq 'f38cb305-28e8-446e-ac4a-c36fe7f823ea' }
    its(:status) { should eq 'closed' }
    its(:scheduled) { should eq Time.new(2014, 11, 01, 16, 00, 00, '+00:00') }
    its(:home_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }
    its(:away_team) { should be_an_instance_of(SportsDataApi::Ncaafb::Team) }

    it 'has home_team players' do
      expect(subject.home_team.players.first).to be_an_instance_of(SportsDataApi::Ncaafb::Player)
    end

    it 'has away_team players' do
      expect(subject.away_team.players.first).to be_an_instance_of(SportsDataApi::Ncaafb::Player)
    end

    it '#summary' do
      expect { subject.summary }.to raise_error(NotImplementedError)
    end
    it '#pbp' do
      expect { subject.pbp }.to raise_error(NotImplementedError)
    end
    its(:roster) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
    it '#injuries' do
      expect { subject.injuries }.to raise_error(NotImplementedError)
    end
    it '#depthchart' do
      expect { subject.depthchart }.to raise_error(NotImplementedError)
    end
    its(:boxscore) { should be_an_instance_of(SportsDataApi::Ncaafb::Game) }
  end
end
