require "spec_helper"

describe SportsDataApi do
  context "user supplied values" do
    let(:level) { "b" }
    before(:each) do
      SportsDataApi.set_key(:foo, 'bar')
      SportsDataApi.access_level = level
    end
    its(:access_level) { should eq level }
    it 'should have the proper key for :foo' do
      expect(SportsDataApi.key(:foo)).to eq 'bar'
    end
  end
end
