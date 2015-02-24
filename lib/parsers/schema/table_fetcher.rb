module Parsers
  module Schema
    class TableFetcher
      def initialize(string)
        @string = string
      end

      def table
        string.scan(/([a-z_]{1,30})/)
      end

      def table_name
        table[0][0]
      end

      private

      attr_reader :string
    end
  end
end
