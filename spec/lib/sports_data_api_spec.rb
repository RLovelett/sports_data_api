require "spec_helper"

describe SportsDataApi do
  context "user supplied values" do
    let(:level) { "b" }
    before(:each) do
      SportsDataApi.set_key(:foo, 'bar')
      SportsDataApi.set_access_level(:foo, level)
    end
    it 'should have the proper access level for :foo' do
      expect(SportsDataApi.access_level(:foo)).to eql 'b'
    end
    it 'should have the proper key for :foo' do
      expect(SportsDataApi.key(:foo)).to eq 'bar'
    end
  end
end
