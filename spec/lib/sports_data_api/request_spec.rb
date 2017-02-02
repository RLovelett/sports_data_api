require 'spec_helper'

class TestClass
  extend SportsDataApi::Request
  API_VERSION = 42
  BASE_URL = 'https://example.com/%{access_level}%{version}'
  SPORT = :jai_alai
end

describe SportsDataApi::Request do
  before do
    SportsDataApi.set_access_level(:jai_alai, 't')
  end
  describe '.response_json' do
    it 'builds the url and parses the json response' do
      json = '{ "foo": "bar" }'
      allow(SportsDataApi).to receive(:generic_request) { json }
      response = TestClass.response_json('/bar.json')

      expect(response).to eq({ 'foo' => 'bar' })
      expect(SportsDataApi).to have_received(:generic_request)
        .with('https://example.com/t42/bar.json', :jai_alai)
    end
  end

  describe '.response_xml' do
    it 'builds the url and parses the xml response' do
      xml = '<foo>bar</foo>'
      allow(SportsDataApi).to receive(:generic_request) { xml }
      response = TestClass.response_xml('/bar.xml')

      expect(response.children.length).to eq 1
      expect(response.children.first.name).to eq('foo')
      expect(response.children.first.text).to eq('bar')
      expect(SportsDataApi).to have_received(:generic_request)
        .with('https://example.com/t42/bar.xml', :jai_alai)
    end
  end
end
