require 'spec_helper'

describe SportsDataApi::Mlb::Teams, vcr: {
    cassette_name: 'sports_data_api_mlb_teams',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  let(:teams) do
    SportsDataApi.set_key(:mlb, api_key(:mlb))
    SportsDataApi.set_access_level(:mlb, 't')
    SportsDataApi::Mlb.teams
  end

  let(:url) { 'http://api.sportsdatallc.org/mlb-t4/teams/2014.xml' }

  let(:dodgers_xml) do
    str = RestClient.get(url, params: { api_key: api_key(:mlb) }).to_s
    xml = Nokogiri::XML(str)
    xml.remove_namespaces!
    xml.xpath('//team[@abbr=\'LA\']')
  end

  let(:dodgers) { SportsDataApi::Mlb::Team.new(dodgers_xml) }

  subject { teams }
  its(:count) { should eq 32 }

  it { subject[:"ef64da7f-cfaf-4300-87b0-9313386b977c"].should eq dodgers }

end
