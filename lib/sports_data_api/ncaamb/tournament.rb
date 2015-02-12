module SportsDataApi
  module Ncaamb
    class Tournament
      attr_reader :id, :status, :year, :season, :status,
        :start_date, :end_date, :name, :location

      def initialize(args={})
        xml = args.fetch(:xml)
        @year = args[:year] ? args[:year].to_i : nil
        @season = args[:season] ? args[:season].to_sym : nil

        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          @id = xml['id']
          @start_date = Time.parse xml['start_date']
          @end_date = Time.parse xml['end_date']
          @status = xml['status']
          @name = xml['name']
          @location = xml['location']
          @status = xml['status']
        end
      end

      def schedule
        Ncaamb.tournament_schedule(year, season, id)
      end

    end
  end
end