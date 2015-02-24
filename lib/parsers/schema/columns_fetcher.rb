module Parsers
  module Schema
    class ColumnsFetcher
      def initialize(string)
        @string = string
      end

      def columns
        string.scan(/("[a-z_]{1,30})/).map { |i| i[0] = i[0].gsub('"', '') }.flatten
      end

      private

      attr_reader :string
    end
  end
end
