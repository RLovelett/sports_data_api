require 'spec_helper'

describe SportsDataApi::Nhl::Teams, vcr: {
    cassette_name: 'sports_data_api_nhl_league_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:nhl, api_key(:nhl))
    SportsDataApi.set_access_level(:nhl, 'ot')
    SportsDataApi::Nhl.teams
  end

  let(:url) { 'https://api.sportsdatallc.org/nhl-ot4/league/hierarchy.xml' }

  let(:kings_xml) do
    str = RestClient.get(url, params: { api_key: api_key(:nhl) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml.xpath('/league/conference/division/team[@alias=\'LA\']')
  end

  let(:kings) { SportsDataApi::Nhl::Team.new(kings_xml) }

  subject { teams }
  its(:conferences) { should eq %w(WESTERN EASTERN).map { |str| str.to_sym } }
  its(:divisions) { should eq %w(PACIFIC CENTRAL ATLANTIC METROPOLITAN).map { |str| str.to_sym } }
  its(:count) { should eq 30 }

  it { subject[:"44151f7a-0f24-11e2-8525-18a905767e44"].should eq kings }

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
      its(:count) { should eq 16 }
    end

    context '#eastern' do
      subject { teams.eastern }
      its(:count) { should eq 16 }
    end

    context '#WESTERN' do
      subject { teams.WESTERN }
      its(:count) { should eq 14 }
    end

    context '#western' do
      subject { teams.western }
      its(:count) { should eq 14 }
    end

    context '#pacific' do
      subject { teams.pacific }
      its(:count) { should eq 7 }
      it { should include kings }
    end

    context '#PACIFIC' do
      subject { teams.PACIFIC }
      its(:count) { should eq 7 }
      it { should include kings }
    end
  end
end
