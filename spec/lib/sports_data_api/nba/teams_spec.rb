require 'spec_helper'

describe SportsDataApi::Nba::Teams, vcr: {
    cassette_name: 'sports_data_api_nba_league_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.access_level = 't'
    SportsDataApi::Nba.teams
  end

  let(:url) { 'http://api.sportsdatallc.org/nba-t3/league/hierarchy.xml' }

  let(:warriors_xml) do
    str = RestClient.get(url, params: { api_key: api_key(:nba) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml.xpath('/league/conference/division/team[@alias=\'GSW\']')
  end

  let(:warriors) { SportsDataApi::Nba::Team.new(warriors_xml) }

  subject { teams }
  its(:conferences) { should eq %w(EASTERN WESTERN).map { |str| str.to_sym } }
  its(:divisions) { should eq %w(SOUTHEAST ATLANTIC CENTRAL NORTHWEST SOUTHWEST PACIFIC).map { |str| str.to_sym } }
  its(:count) { should eq 30 }

  it { subject[:"583ec825-fb46-11e1-82cb-f4ce4684ea4c"].should eq warriors }

  describe 'meta methods' do
    it { should respond_to :EASTERN }
    it { should respond_to :WESTERN }
    it { should respond_to :eastern }
    it { should respond_to :western }
    it { should respond_to :ATLANTIC }
    it { should respond_to :atlantic }
    it { should respond_to :PACIFIC }

    its(:EASTERN) { should be_a Array }
    its(:WESTERN) { should be_a Array }

    context '#EASTERN' do
      subject { teams.EASTERN }
      its(:count) { should eq 15 }
    end

    context '#eastern' do
      subject { teams.eastern }
      its(:count) { should eq 15 }
    end

    context '#WESTERN' do
      subject { teams.WESTERN }
      its(:count) { should eq 15 }
    end

    context '#western' do
      subject { teams.western }
      its(:count) { should eq 15 }
    end

    context '#pacific' do
      subject { teams.pacific }
      its(:count) { should eq 5 }
      it { should include warriors }
    end

    context '#PACIFIC' do
      subject { teams.PACIFIC }
      its(:count) { should eq 5 }
      it { should include warriors }
    end
  end
end
