module SportsDataApi
  module Ncaamb
    class Teams
      include Enumerable

      attr_reader :conferences, :divisions

      ##
      # Initialize by passing the raw XML returned from the API
      def initialize(xml)
        @teams = []
        xml = xml.first if xml.is_a? Nokogiri::XML::NodeSet
        if xml.is_a? Nokogiri::XML::Element
          xml.xpath('division').each do |division|
            # Division ID, e.g., D1 or D2
            dname = division['alias']

            division.xpath('conference').each do |conference|
              # conference ID, e.g., ATLANTIC, PACIFIC
              cname = conference['alias']

              # Create a new team
              @teams << conference.xpath('team').map { |team| Team.new(team, cname, dname) }
            end
          end
        end

        @teams.flatten!

        uniq_conferences = @teams.map { |team| team.conference.upcase }.uniq
        @allowed_conferences = uniq_conferences.map { |str| str.to_sym }.concat(uniq_conferences.map { |str| str.downcase.to_sym })
        @conferences = uniq_conferences.map { |conf| conf.to_sym }

        uniq_divisions = @teams.map { |team| team.division.upcase }.uniq
        @divisions =  @teams.map { |team| team.division.to_sym }.uniq
        @allowed_divisions = uniq_divisions.map { |str| str.to_sym }.concat(uniq_divisions.map { |str| str.downcase.to_sym })
      end

      def [](search_index)
        found_index = @teams.index(search_index)
        unless found_index.nil?
          @teams[found_index]
        end
      end

      ##
      #
      def respond_to?(method)
        @allowed_conferences.include?(method) || @allowed_divisions.include?(method)
      end

      ##
      #
      def method_missing(method)
        if @allowed_conferences.include?(method)
          @teams.select do |team|
            up = team.conference.upcase.to_sym
            dw = team.conference.downcase.to_sym
            up === method || dw === method
          end
        elsif @allowed_divisions.include?(method)
          @teams.select do |team|
            up = team.division.upcase.to_sym
            dw = team.division.downcase.to_sym
            up === method || dw === method
          end
        end
      end

      ##
      # Make the class Enumerable
      def each(&block)
        @teams.each do |team|
          if block_given?
            block.call team
          else
            yield team
          end
        end
      end
    end
  end
end
