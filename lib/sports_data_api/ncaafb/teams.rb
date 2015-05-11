module SportsDataApi
  module Ncaafb
    class Teams
      include Enumerable

      attr_reader :conferences, :subdivisions, :divisions

      def initialize(teams_hash)
        @teams = []
        @allowed_divisions = []
        @allowed_conferences = []
        @allowed_subdivisions = []
        did = teams_hash['id']
        teams_hash['conferences'].each do |conference_hash|
          # Conference ID. e.g ACC
          cid = conference_hash['id']
          @teams << Array(conference_hash['teams']).map { |team_hash| Team.new(team_hash, cid) }

          # If Sub Division
          Array(conference_hash['subdivisions']).each do |subdivision|
            # SUB Division ID, e.g., ACC-ATLANTIC
            sdid = subdivision['id']
            @teams << subdivision['teams'].map { |team_hash| Team.new(team_hash, cid, did, sdid) }
          end
        end

        @teams.flatten!

        uniq_conferences = @teams.map { |team| team.conference.upcase }.uniq
        @allowed_conferences = concat_allowed_methods(uniq_conferences)
        @conferences = uniq_conferences.map(&:to_sym)

        @divisions = select_divisions_by_type(:division)
        @subdivisions = select_divisions_by_type(:subdivision)

        @allowed_divisions.concat(concat_allowed_methods(@divisions))
        @allowed_subdivisions.concat(concat_allowed_methods(@subdivisions))
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
        @allowed_conferences.include?(method) || @allowed_divisions.include?(method) || @allowed_subdivisions
      end

      ##
      #
      def method_missing(method, *args, &block)
        case true
        when @allowed_conferences.include?(method)
          select_by(:conference, method)
        when @allowed_divisions.include?(method)
          select_by(:division, method)
        when @allowed_subdivisions.include?(method)
          select_by(:subdivision, method)
        else
          super(method, *args, &block)
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
      private

      def select_by(type, method)
        normalize_method = method.downcase.to_sym
        @teams.select do |team|
          normalize_method == team.send(type).to_s.downcase.to_sym
        end
      end

      def select_divisions_by_type(division_type)
        (@teams.map { |team| team.send(division_type).to_s.upcase.to_sym }.uniq - [:"", nil])
      end

      def concat_allowed_methods(list)
        list.map { |str| str.to_sym }.concat(list.map { |str| str.downcase.to_sym })
      end
    end
  end
end
