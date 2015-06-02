module SportsDataApi
  module Nfl
    class Action
      attr_reader :sequence, :id, :clock, :type, :summary, :updated, :side, :yard_line, :down, :yfd, :play_type, :details

      def initialize(quarter_hash)
        @sequence = quarter_hash["sequence"]
        @id = quarter_hash["id"]
        @clock = quarter_hash["clock"]
        @type = quarter_hash["type"]
        @summary = quarter_hash["summary"]
        @updated = quarter_hash["updated"]
        @side = quarter_hash["side"]
        @yard_line = quarter_hash["yard_line"]
        @play_type = quarter_hash["play_type"]
        @details = quarter_hash["details"]
        @down = quarter_hash["down"]
        @yfd = quarter_hash["yfd"]
      end

    end
  end
end
