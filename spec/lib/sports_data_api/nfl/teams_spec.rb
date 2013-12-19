require 'spec_helper'

describe SportsDataApi::Nfl::Teams, vcr: {
    cassette_name: 'sports_data_api_nfl_team_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:nfl, api_key(:nfl))
    SportsDataApi.access_level = 't'
    SportsDataApi::Nfl.teams
  end

  let(:url) { 'http://api.sportsdatallc.org/nfl-t1/teams/hierarchy.xml' }

  let(:dolphins_xml) do
    str = RestClient.get(url, params: { api_key: api_key(:nfl) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml.xpath('/league/conference/division/team[@id=\'MIA\']')
  end

  let(:dolphins) { SportsDataApi::Nfl::Team.new(dolphins_xml) }

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
end

