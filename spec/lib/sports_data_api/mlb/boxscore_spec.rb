require 'spec_helper'

describe SportsDataApi::Mlb::Boxscore, vcr: {
    cassette_name: 'sports_data_api_mlb_game_boxscore',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do

  context "closed game" do
    let(:boxscore) do
      SportsDataApi.set_key(:mlb, api_key(:mlb))
      SportsDataApi.set_access_level(:mlb, 't')
      SportsDataApi::Mlb.game_boxscore("000c465f-7c8c-46bb-8ea7-c26b2bc7c296")
    end

    subject { boxscore }
    it "inning eq 9" do
      boxscore.game_state[:inning].to_i.should eq 9
    end
    it "inning_half eq t" do
      boxscore.game_state[:inning_half].should eq 'T'
    end
  end

  context "inprogress game" do
    let(:url) { 'http://developer.sportsdatallc.com/files/mlb_v4_game_boxscore_example.xml' }

    let(:boxscore_xml) do
      str = RestClient.get(url).to_s
      xml = Nokogiri::XML(str)
      xml.remove_namespaces!
      xml.xpath('/boxscore').first
    end

    let(:boxscore) { SportsDataApi::Mlb::Boxscore.new(boxscore_xml)}

    subject { boxscore }
    it "inning eq 12" do
      boxscore.game_state[:inning].to_i.should eq 12
    end
    it "inning_half eq t" do
      boxscore.game_state[:inning_half].should eq 'T'
    end
  end
end
