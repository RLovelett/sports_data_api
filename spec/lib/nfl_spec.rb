require 'spec_helper'

describe SportsDataApi::Nfl do
  let(:key) { "1234567890abcdef" }
  describe ".schedule" do
    it "creates a valid Sports Data LLC url" do
      SportsDataApi.stub(:key).and_return(key)
      RestClient.stub(:get).with("http://api.sportsdatallc.org/nfl-t1/2012/REG/schedule.xml", params: { api_key: key }).and_return(schedule_xml)
      subject.schedule(2012, :REG)
    end
    it "creates a SportsDataApi::Exception when there is no response from the api" do
      error = RestClient::ResourceNotFound.new
      error.stub_chain(:response, :headers).and_return(Hash.new)
      SportsDataApi.stub(:key).and_return(key)
      RestClient.stub(:get).and_raise(error)
      expect { subject.schedule(2999, :REG) }.to raise_error(SportsDataApi::Exception)
    end

    describe "returned data structures" do
      before(:each) { RestClient.stub(:get).and_return(schedule_xml) }
      let(:season) { SportsDataApi::Nfl.schedule(2012, :REG) }
      describe "SportsDataApi::Nfl::Season" do
        subject { season }
        it { should be_an_instance_of(SportsDataApi::Nfl::Season) }
        its(:year) { should eq 2012 }
        its(:type) { should eq :REG }
        its(:weeks) { should have(17).weeks }
      end
      describe "SportsDataApi::Nfl::Week" do
        subject { season.weeks.first }
        it { should be_an_instance_of(SportsDataApi::Nfl::Week) }
        its(:number) { should eq 1 }
        its(:games) { should have(16).games }
      end
      describe "SportsDataApi::Nfl::Game" do
        subject { season.weeks.first.games.first }
        it { should be_an_instance_of(SportsDataApi::Nfl::Game) }
        its(:id) { should eq "8c0bce5a-7ca2-41e5-9838-d1b8c356ddc3" }
        its(:scheduled) { should eq Time.new(2012, 9, 5, 19, 30, 00, "-05:00") }
        its(:home) { should eq "NYG" }
        its(:away) { should eq "DAL" }
        its(:status) { should eq "closed" }
      end
    end
  end

  describe ".boxscore" do
    it "creates a valid SportsData LLC url" do
      SportsDataApi.stub(:key).and_return(key)
      RestClient.stub(:get).with("http://api.sportsdatallc.org/nfl-t1/2012/REG/9/MIA/IND/boxscore.xml", params: { api_key: key }).and_return(boxscore_xml)
      subject.boxscore(2012, :REG, 9, "IND", "MIA")
    end
    it "creates a SportsDataApi::Exception when there is no response from the api" do
      error = RestClient::ResourceNotFound.new
      error.stub_chain(:response, :headers).and_return(Hash.new)
      SportsDataApi.stub(:key).and_return(key)
      RestClient.stub(:get).and_raise(error)
      expect { subject.boxscore(2999, :REG, 9, "IND", "MIA") }.to raise_error(SportsDataApi::Exception)
    end
    describe "returned data structures" do
      let(:boxscore) { SportsDataApi::Nfl.boxscore(2012, :REG, 9, "IND", "MIA") }
      before(:each) { RestClient.stub(:get).and_return(boxscore_xml) }
      describe "SportsDataApi::Nfl::Game" do
        subject { boxscore }
        it { should be_an_instance_of(SportsDataApi::Nfl::Game) }
        its(:id) { should eq "55d0b262-98ff-49fa-95c8-5ab8ec8cbd34" }
        its(:scheduled) { should eq Time.new(2012, 11, 4, 18, 00, 00, "+00:00") }
        its(:home) { should eq "IND" }
        its(:away) { should eq "MIA" }
        its(:status) { should eq "inprogress" }
        its(:quarter) { should eq 2 }
        its(:clock) { should eq "02:29" }
        its(:home_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
        its(:away_team) { should be_an_instance_of(SportsDataApi::Nfl::Team) }
      end
      describe "SportsDataApi::Nfl::Team" do
        describe "home team" do
          subject { boxscore.home_team }
          it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
          its(:id) { should eq "IND" }
          its(:name) { should eq "Colts" }
          its(:market) { should eq "Indianapolis" }
          its(:remaining_challenges) { should eq 1 }
          its(:remaining_timeouts) { should eq 2 }
          its(:score) { should eq 10 }
          its(:quarters) { should have(4).scores }
          its(:quarters) { should include(7, 3, 0, 0) }
        end
        describe "away team" do
          subject { boxscore.away_team }
          it { should be_an_instance_of(SportsDataApi::Nfl::Team) }
          its(:id) { should eq "MIA" }
          its(:name) { should eq "Dolphins" }
          its(:market) { should eq "Miami" }
          its(:remaining_challenges) { should eq 2 }
          its(:remaining_timeouts) { should eq 2 }
          its(:score) { should eq 17 }
          its(:quarters) { should have(4).scores }
          its(:quarters) { should include(3, 14, 0, 0) }
        end
      end
    end
  end

  describe ".season?" do
    context :PRE do
      it { subject.season?(:PRE).should be_true }
    end
    context :REG do
      it { subject.season?(:REG).should be_true }
    end
    context :PST do
      it { subject.season?(:PST).should be_true }
    end
    context :pre do
      it { subject.season?(:pre).should be_false }
    end
    context :reg do
      it { subject.season?(:reg).should be_false }
    end
    context :pst do
      it { subject.season?(:pst).should be_false }
    end
  end
end
