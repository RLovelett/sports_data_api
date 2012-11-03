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
