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
      xml = '<foo><bar>Man</bar><tar>Zar</tar></foo>'
      allow(SportsDataApi).to receive(:generic_request) { xml }
      response = TestClass.response_xml('/bar.xml')

      expect(response).to be_an_instance_of(Nokogiri::XML::Document)
      expect(response.children.length).to eq 1
      expect(response.children.first.children.length).to eq 2
      expect(SportsDataApi).to have_received(:generic_request)
        .with('https://example.com/t42/bar.xml', :jai_alai)
    end
  end

  describe '.response_xml_xpath' do
    it 'fetches url and then gets xpath' do
      xml = '<foo><bar>Man</bar><tar>Zar</tar></foo>'
      allow(SportsDataApi).to receive(:generic_request) { xml }
      response = TestClass.response_xml_xpath('/bar.xml', '/foo/bar')

      expect(response).to be_an_instance_of(Nokogiri::XML::NodeSet)
      expect(response.length).to eq 1
      expect(response.first.name).to eq 'bar'
      expect(response.first.text).to eq 'Man'
      expect(SportsDataApi).to have_received(:generic_request)
        .with('https://example.com/t42/bar.xml', :jai_alai)
    end
  end
end
