module SportsDataApi
  module Request
    def response_json(path)
      response = make_request(path)
      MultiJson.load(response.to_s)
    end

    def response_xml(path)
      response = make_request(path)
      Nokogiri::XML(response.to_s).remove_namespaces!
    end

    private

    def make_request(path)
      SportsDataApi.generic_request("#{base_url}#{path}", sport)
    end

    def base_url
      @base_url ||= self::BASE_URL % {
        access_level: SportsDataApi.access_level(sport),
        version: self::API_VERSION
      }
    end

    def sport
      @sport ||= self::SPORT
    end
  end
end
