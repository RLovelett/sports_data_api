require 'spec_helper'

describe SportsDataApi::Ncaafb::Teams, vcr: {
    cassette_name: 'sports_data_api_ncaafb_team_hierarchy',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do

  let(:teams) do
    SportsDataApi.set_key(:ncaafb, api_key(:ncaafb))
    SportsDataApi.set_access_level(:ncaafb, 't')
    SportsDataApi::Ncaafb.teams(:FBS)
  end

  let(:url) { 'https://api.sportsdatallc.org/ncaafb-t1/teams/fbs/hierarchy.json' }
  let(:subdivisions_list) { [:"ACC-ATLANTIC", :"ACC-COASTAL", :"AAC-EAST", :"AAC-WEST", :"BIG-TEN-EAST", :"BIG-TEN-WEST", :"CONFERENCE-USA-EAST", :"CONFERENCE-USA-WEST", :"MID-AMERICAN-EAST", :"MID-AMERICAN-WEST", :"MOUNTAIN-WEST-MOUNTAIN", :"MOUNTAIN-WEST-WEST", :"PAC-12-SOUTH", :"PAC-12-NORTH", :"SEC-WEST", :"SEC-EAST"] }
  let(:divisions_list) { [:"FBS"] }
  let(:louisville_hash) do
    str = RestClient.get(url, params: { api_key: api_key(:ncaafb) }).to_s
    teams_hash = MultiJson.load(str)
    teams_hash['conferences'][0]['subdivisions'][0]['teams'][0]
  end

  let(:louisville) { SportsDataApi::Ncaafb::Team.new(louisville_hash) }

  subject { teams }
  its(:conferences) { should eq([:ACC, :AAC, :"BIG-12", :"BIG-TEN", :"CONFERENCE-USA", :"IA-INDEPENDENTS", :"MID-AMERICAN", :"MOUNTAIN-WEST", :"PAC-12", :SEC, :"SUN-BELT"]) }

  its(:subdivisions) { should eq(subdivisions_list.map { |str| str.to_sym })}
  its(:divisions) { should eq(divisions_list) }

  its(:count) { should eq 129 }

  it { subject[:LOU].should eq louisville }

  describe 'meta methods' do
    it { should respond_to :FBS }
    it { should respond_to :fbs }

    its(:FBS) { should be_a Array }
    its(:fbs) { should be_a Array }
    its(:ACC) { should be_a Array }
    its(:aac) { should be_a Array }

    describe '#method_missing' do
      it 'raise error' do
        expect{subject.unknow_division}.to raise_error(NoMethodError)
      end
    end

    describe '#ACC' do
      context "upcase" do
        subject { teams.ACC }
        its(:count) { should eq 14 }
      end

      context "downcase" do
        subject { teams.acc }
        its(:count) { should eq 14 }
      end
    end

    describe '#FBS' do
      context "upcase" do
        subject { teams.FBS }
        its(:count) { should eq 105 }
      end

      context "downcase" do
        subject { teams.fbs }
        its(:count) { should eq 105 }
      end
    end
  end
end

