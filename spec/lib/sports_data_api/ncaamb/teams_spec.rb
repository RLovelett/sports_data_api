require 'spec_helper'

describe SportsDataApi::Ncaamb::Teams, vcr: {
    cassette_name: 'sports_data_api_ncaamb_league_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:ncaamb, api_key(:ncaamb))
    SportsDataApi.set_access_level(:ncaamb, 't')
    SportsDataApi::Ncaamb.teams
  end

  let(:url) { 'https://api.sportsdatallc.org/ncaamb-t3/league/hierarchy.xml' }

  let(:badgers_xml) do
    str = RestClient.get(url, params: { api_key: api_key(:ncaamb) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml.xpath('/league/division/conference/team[@id=\'c7569eae-5b93-4197-b204-6f3a62146b25\']')
  end

  let(:badgers) { SportsDataApi::Ncaamb::Team.new(badgers_xml, "BIG10", "D1") }

  subject { teams }
  its(:divisions) { should eq %w(ACCA NAIA NCAIA USCAA D2 D1 D3 NCCAA).map { |str| str.to_sym } }
  its(:conferences) { should eq %w(ACCA-IND KCAC MCC MSC PCAC HAAC GCAC KIAC NAIA-AAC CROSS CCAC RRAC CCC WHAC TSC DIII-MCC AII NSAA SSAC CALPAC GSAC AMC FRONTIER NAIA-SAC NCAIA USCAA-D2 HVMAC OCAC USCAA-D1 USCAA CIAA GSC NCCAA G-MAC CCAA CC GLVC SAC MIAA SIAC NSIC GLIAC GAC ECC GNAC LSC HC SSC NE10 CACC MEC RMAC DII-IND PSAC PBC PACWEST-D2 PAC12 OVC MVC BIG12 SUNBELT DI-IND BIGSKY AAC SOUTHERN SUMMIT BIGWEST CUSA WAC SOUTHLAND SWAC MEAC ACC AS PATRIOT BIGSOUTH HORIZON MWC SEC MAC BIG10 AE NE IVY COLONIAL WCC BIGEAST A10 MAAC CENT LAND DIII-HC ECAC CSAC MASCAC DIII-SAA OAC NCAC SKY CUNYAC M-IAA UAA TCCC UMAC ASC NECC MIAC SLIAC SCIAC PAC NJAC USAS E8 DIII-GNAC SCAC IIAC NEWMAC DIII-IND CCIW NWC ODAC WNYAC AMCC NEAC NAC NACC CAC D2-MID-WEST D2-EAST D1-WEST D1-MID-EAST D2-MID-EAST D2-SOUTH D2-SOUTHWEST D1-SOUTH D1-CENT).map { |str| str.to_sym } }
  its(:count) { should eq 946 }

  it { subject[:"c7569eae-5b93-4197-b204-6f3a62146b25"].should eq badgers }

  describe 'meta methods' do
    it { should respond_to :D1 }
    it { should respond_to :D2 }
    it { should respond_to :d1 }
    it { should respond_to :d2 }
    it { should respond_to :BIG10 }
    it { should respond_to :big10 }
    it { should respond_to :IVY }

    its(:D1) { should be_a Array }
    its(:D2) { should be_a Array }

    context '#D1' do
      subject { teams.D1 }
      its(:count) { should eq 351 }
    end

    context '#d1' do
      subject { teams.d1 }
      its(:count) { should eq 351 }
    end

    context '#D2' do
      subject { teams.D2 }
      its(:count) { should eq 311 }
    end

    context '#d2' do
      subject { teams.d2 }
      its(:count) { should eq 311 }
    end

    context '#big10' do
      subject { teams.big10 }
      its(:count) { should eq 14 }
      it { should include badgers }
    end

    context '#BIG10' do
      subject { teams.BIG10 }
      its(:count) { should eq 14 }
      it { should include badgers }
    end
  end
end
