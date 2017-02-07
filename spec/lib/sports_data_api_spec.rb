require 'spec_helper'

describe SportsDataApi do
  context 'user supplied values' do
    let(:level) { 'b' }
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
  describe '.generic_request' do
    context 'when timesout' do
      it 'raises a timeout error' do
        stub_request(:any, /example.com/).to_timeout
        expect do
          SportsDataApi.generic_request('https://example.com', 'sport')
        end.to raise_error(
          SportsDataApi::Exception,
          'The API did not respond in a reasonable amount of time')
      end
    end
    context 'when valid response' do
      it 'returns the response' do
        allow(RestClient).to receive(:get) { '{}' }
        SportsDataApi.set_key(:sport, 'key')

        response = SportsDataApi.generic_request('https://example.com', :sport)

        expect(response).to eq '{}'
        expect(RestClient).to have_received(:get)
          .with('https://example.com', { params: { api_key: 'key' } })
      end
    end
    context 'when RestClient exception' do
      context 'when has x_server_error header' do
        it 'returns error name' do
          error = double(headers: { x_server_error: '{"message":"Server Error"}' })
          allow(RestClient).to receive(:get).and_raise(RestClient::Exception.new(error))
          SportsDataApi.set_key(:sport, 'key')

          expect do
            SportsDataApi.generic_request('https://example.com', :sport)
          end.to raise_error(SportsDataApi::Exception, 'Server Error')

          expect(RestClient).to have_received(:get)
            .with('https://example.com', { params: { api_key: 'key' } })
        end
      end
      context 'when mashery error' do
        it 'returns error name' do
          error = double(headers: { x_mashery_error_code: '527 Error' })
          allow(RestClient).to receive(:get).and_raise(RestClient::Exception.new(error))
          SportsDataApi.set_key(:sport, 'key')

          expect do
            SportsDataApi.generic_request('https://example.com', :sport)
          end.to raise_error(SportsDataApi::Exception, '527 Error')

          expect(RestClient).to have_received(:get)
            .with('https://example.com', { params: { api_key: 'key' } })
        end
      end
      context 'when other error' do
        it 'returns generic error message' do
          error = double(headers: { error: 'true' })
          allow(RestClient).to receive(:get).and_raise(RestClient::Exception.new(error))
          SportsDataApi.set_key(:sport, 'key')

          expect do
            SportsDataApi.generic_request('https://example.com', :sport)
          end.to raise_error(SportsDataApi::Exception, 'The server did not specify a message')

          expect(RestClient).to have_received(:get)
            .with('https://example.com', { params: { api_key: 'key' } })
        end
      end
    end
  end
end
