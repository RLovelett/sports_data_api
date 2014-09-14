require 'spec_helper'

describe SportsDataApi::Nfl::Teams, vcr: {
    cassette_name: 'sports_data_api_nfl_team_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.set_access_level(:nfl, 't')
    SportsDataApi::Nfl.teams
  end

  let(:url) { 'http://api.sportsdatallc.org/nfl-t1/teams/hierarchy.xml' }
  let(:xml) do
    str = RestClient.get(url, params: { api_key: api_key(:nfl) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml
  end

  let(:dolphins_xml) do
    xml.xpath('/league/conference/division/team[@id=\'MIA\']')
  end

  let(:patriots_xml) do
    xml.xpath('/league/conference/division/team[@id=\'NE\']')
  end

  let(:jaguars_xml) do
    xml.xpath('/league/conference/division/team[@id=\'JAC\']')
  end

  let(:buccaneers_xml) do
    xml.xpath('/league/conference/division/team[@id=\'TB\']')
  end

  let(:dolphins) { SportsDataApi::Nfl::Team.new(dolphins_xml, 'AFC', 'AFC_EAST') }
  let(:patriots) { SportsDataApi::Nfl::Team.new(patriots_xml, 'AFC', 'AFC_EAST') }
  let(:jaguars) { SportsDataApi::Nfl::Team.new(jaguars_xml, 'AFC', 'AFC_SOUTH') }
  let(:buccaneers) { SportsDataApi::Nfl::Team.new(buccaneers_xml, 'NFC', 'NFC_SOUTH') }

  subject { teams }
  its(:conferences) { should eq %w(AFC NFC).map { |str| str.to_sym } }
  its(:divisions) { should eq %w(AFC_EAST AFC_NORTH AFC_SOUTH AFC_WEST NFC_EAST NFC_NORTH NFC_SOUTH NFC_WEST).map { |str| str.to_sym } }
  its(:count) { should eq 32 }

  it { subject[:MIA].should eq dolphins }

  describe 'meta methods' do
    it { should respond_to :AFC }
    it { should respond_to :NFC }
    it { should respond_to :afc }
    it { should respond_to :nfc }
    it { should respond_to :NFC_WEST }
    it { should respond_to :afc_east }
    it { should respond_to :nfc_west }

    its(:AFC) { should be_a Array }
    its(:NFC) { should be_a Array }

    context '#AFC' do
      subject { teams.AFC }
      its(:count) { should eq 16 }
    end

    context '#afc' do
      subject { teams.afc }
      its(:count) { should eq 16 }
    end

    context '#NFC' do
      subject { teams.NFC }
      its(:count) { should eq 16 }
    end

    context '#nfc' do
      subject { teams.nfc }
      its(:count) { should eq 16 }
    end

    context '#afc_east' do
      subject { teams.afc_east }
      its(:count) { should eq 4 }
      it { should include dolphins }
    end

    context '#AFC_EAST' do
      subject { teams.AFC_EAST }
      its(:count) { should eq 4 }
      it { should include dolphins }
    end
  end

  describe '#divisional_rivals?' do
    it { subject.divisional_rivals?(dolphins, patriots).should be_true }
    it { subject.divisional_rivals?(patriots, dolphins).should be_true }
    it { subject.divisional_rivals?(dolphins, jaguars).should be_false }
    it { subject.divisional_rivals?(jaguars, dolphins).should be_false }
  end

  describe '#conference_rivals?' do
    it { subject.conference_rivals?(dolphins, patriots).should be_true }
    it { subject.conference_rivals?(patriots, dolphins).should be_true }
    it { subject.conference_rivals?(dolphins, jaguars).should be_true }
    it { subject.conference_rivals?(dolphins, buccaneers).should be_false }
    it { subject.conference_rivals?(buccaneers, dolphins).should be_false }
  end
end
